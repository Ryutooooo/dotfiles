#!/bin/bash
DIR_NAME=$(basename "$(pwd)")
ICON_PATH="$HOME/.claude/hooks/icon.png"

# stdin から JSON を読み取る
INPUT=$(cat)
HOOK_EVENT=$(echo "$INPUT" | jq -r '.hook_event_name // empty')

# ターミナルを検出する関数
detect_terminal() {
    local term_name=""

    # tmux 内の場合、クライアントの親プロセスを辿る
    if [ -n "$TMUX" ]; then
        local current_pid
        current_pid=$(tmux display-message -p '#{client_pid}' 2>/dev/null)

        # 親プロセスを辿ってターミナルを探す
        for _ in {1..10}; do
            local comm
            comm=$(ps -o comm= -p "$current_pid" 2>/dev/null)

            case "$comm" in
                *alacritty*|*Alacritty*)
                    term_name="Alacritty"
                    break
                    ;;
                *ghostty*|*Ghostty*)
                    term_name="ghostty"
                    break
                    ;;
                *Terminal*)
                    term_name="Apple_Terminal"
                    break
                    ;;
                *iTerm*|*iterm*)
                    term_name="iTerm.app"
                    break
                    ;;
            esac

            local parent_pid
            parent_pid=$(ps -o ppid= -p "$current_pid" 2>/dev/null | tr -d ' ')
            if [ -z "$parent_pid" ] || [ "$parent_pid" = "1" ]; then
                break
            fi
            current_pid=$parent_pid
        done
    else
        # tmux 外の場合は TERM_PROGRAM を使用
        term_name="$TERM_PROGRAM"
    fi

    echo "$term_name"
}

TERM_NAME=$(detect_terminal)

# ターミナルの親プロセス PID を取得（Alacritty のウィンドウ特定用）
detect_terminal_pid() {
    local current_pid

    # tmux 内の場合、クライアントの親プロセスを辿る
    if [ -n "$TMUX" ]; then
        current_pid=$(tmux display-message -p '#{client_pid}' 2>/dev/null)
    else
        current_pid="$$"
    fi

    for _ in {1..15}; do
        local comm
        comm=$(ps -o comm= -p "$current_pid" 2>/dev/null)
        case "$comm" in
            *alacritty*|*Alacritty*)
                echo "$current_pid"
                return
                ;;
        esac
        local parent_pid
        parent_pid=$(ps -o ppid= -p "$current_pid" 2>/dev/null | tr -d ' ')
        if [ -z "$parent_pid" ] || [ "$parent_pid" = "1" ]; then
            break
        fi
        current_pid=$parent_pid
    done
    echo ""
}

TERM_PID=""
if [ "$TERM_NAME" = "Alacritty" ]; then
    TERM_PID=$(detect_terminal_pid)
fi

# ターミナルのバンドル識別子を設定
case "$TERM_NAME" in
    Alacritty)
        BUNDLE_ID="org.alacritty"
        ;;
    ghostty)
        BUNDLE_ID="com.mitchellh.ghostty"
        ;;
    Apple_Terminal)
        BUNDLE_ID="com.apple.Terminal"
        ;;
    iTerm.app)
        BUNDLE_ID="com.googlecode.iterm2"
        ;;
    *)
        BUNDLE_ID=""
        ;;
esac

if [ -n "$TMUX" ]; then
    if [ -n "$TMUX_PANE" ]; then
        TMUX_SESSION=$(tmux display-message -p -t "$TMUX_PANE" '#S')
        TMUX_WINDOW_NAME=$(tmux display-message -p -t "$TMUX_PANE" '#W')
        TMUX_WINDOW_INDEX=$(tmux display-message -p -t "$TMUX_PANE" '#I')
        TMUX_CLIENT_NAME=$(tmux display-message -p -t "$TMUX_PANE" '#{client_name}')
    else
        TMUX_SESSION=$(tmux display-message -p '#S')
        TMUX_WINDOW_NAME=$(tmux display-message -p '#W')
        TMUX_WINDOW_INDEX=$(tmux display-message -p '#I')
        TMUX_CLIENT_NAME=$(tmux display-message -p '#{client_name}')
    fi
    LOCATION="${TMUX_SESSION} - ${TMUX_WINDOW_NAME}"
else
    LOCATION="$DIR_NAME"
fi

# 通知時刻を追加
TIMESTAMP=$(date '+%H:%M')
TITLE="${TIMESTAMP} ${LOCATION}"

# hook_event_name でイベントタイプを判定
if [ "$HOOK_EVENT" = "Notification" ]; then
    MESSAGE="Claude Code is waiting"
else
    MESSAGE="Claude Code Finished"
fi

# クリック時に実行するスクリプトを作成
CLICK_SCRIPT="$HOME/.claude/hooks/notification-click.sh"

if [ -n "$TMUX" ] && [ -n "$BUNDLE_ID" ]; then
    # tmux 内: クリック時にターミナルをアクティブ化 + tmuxウィンドウを選択
    cat > "$CLICK_SCRIPT" << EOF
#!/bin/bash
# ログ出力（デバッグ用）
exec >> "\$HOME/.claude/hooks/click.log" 2>&1
echo ""
echo "\$(date): Click handler executed"
echo "BUNDLE_ID: $BUNDLE_ID"
echo "TERM_PID: $TERM_PID"
echo "TMUX_SESSION: $TMUX_SESSION"
echo "TMUX_WINDOW_INDEX: $TMUX_WINDOW_INDEX"
echo "TMUX_CLIENT_NAME: $TMUX_CLIENT_NAME"

# ターミナルをアクティブ化（PID → 失敗時に open -b）
echo "Activating terminal..."
activated=0
if [ -n "$TERM_PID" ]; then
    if osascript - "$TERM_PID" "$TMUX_SESSION" << 'APPLESCRIPT'
on run argv
    set pid to (item 1 of argv) as integer
    set sessionName to (item 2 of argv) as text
    tell application "System Events"
        set theProc to first process whose unix id is pid
        set frontmost of theProc to true
        set targetWindow to missing value
        -- セッション名を含むウィンドウを探す
        repeat with w in windows of theProc
            set winName to name of w
            if winName contains sessionName then
                set targetWindow to w
                exit repeat
            end if
        end repeat
        -- 見つかればそのウィンドウを、なければ最前面を上げる
        if targetWindow is not missing value then
            perform action "AXRaise" of targetWindow
        else if (count of windows of theProc) > 0 then
            perform action "AXRaise" of front window of theProc
        end if
    end tell
end run
APPLESCRIPT
    then
        activated=1
        echo "Activated by PID"
    fi
fi

if [ "\$activated" -ne 1 ]; then
    open -b "$BUNDLE_ID"
fi

# tmuxセッション・ウィンドウを選択
echo "Selecting tmux session and window..."

# 方法1: 保存されたクライアント名で切り替え
if /opt/homebrew/bin/tmux switch-client -c "$TMUX_CLIENT_NAME" -t "$TMUX_SESSION:$TMUX_WINDOW_INDEX" 2>/dev/null; then
    echo "Switched via saved client: $TMUX_CLIENT_NAME"
else
    # 方法2: Alacrittyにアタッチされているクライアントを探して切り替え
    echo "Saved client not found, searching for active client..."
    for client in \$(/opt/homebrew/bin/tmux list-clients -F '#{client_name}' 2>/dev/null); do
        if /opt/homebrew/bin/tmux switch-client -c "\$client" -t "$TMUX_SESSION:$TMUX_WINDOW_INDEX" 2>/dev/null; then
            echo "Switched via client: \$client"
            break
        fi
    done
fi
echo "Done"
EOF
    chmod +x "$CLICK_SCRIPT"

    terminal-notifier -message "$MESSAGE" -title "$TITLE" -contentImage "$ICON_PATH" -sound default -execute "$CLICK_SCRIPT" 2>/dev/null || \
    osascript -e "display notification \"$MESSAGE\" with title \"$TITLE\" sound name \"default\""
elif [ -n "$BUNDLE_ID" ]; then
    # tmux 外: アプリをアクティブにするだけ
    terminal-notifier -message "$MESSAGE" -title "$TITLE" -contentImage "$ICON_PATH" -sound default -activate "$BUNDLE_ID" 2>/dev/null || \
    osascript -e "display notification \"$MESSAGE\" with title \"$TITLE\" sound name \"default\"" -e "tell application id \"$BUNDLE_ID\" to activate"
else
    terminal-notifier -message "$MESSAGE" -title "$TITLE" -contentImage "$ICON_PATH" -sound default 2>/dev/null || \
    osascript -e "display notification \"$MESSAGE\" with title \"$TITLE\" sound name \"default\""
fi
