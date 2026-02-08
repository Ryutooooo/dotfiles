#!/bin/bash
# define-session-color.sh - セッション名からハッシュベースで決定的に色を生成する
# Usage: define-session-color.sh <session_name> <variant>
# Variants: base, light1, light2, light3, light4, fg, fg_light

SESSION_NAME="$1"
VARIANT="$2"

if [ -z "$SESSION_NAME" ] || [ -z "$VARIANT" ]; then
    echo "Usage: $0 <session_name> <base|light1|light2|light3|light4|fg|fg_light>" >&2
    exit 1
fi

# --- セッション名のMD5ハッシュからhue値を決定 ---
get_hash() {
    local name="$1"
    if command -v md5 &>/dev/null; then
        echo -n "$name" | md5
    elif command -v md5sum &>/dev/null; then
        echo -n "$name" | md5sum | cut -d' ' -f1
    else
        # fallback: od ベースの簡易ハッシュ
        echo -n "$name" | od -A n -t x1 | tr -d ' \n' | head -c 32
    fi
}

HASH=$(get_hash "$SESSION_NAME")
HUE=$(( 16#${HASH:0:4} % 360 ))
SATURATION=80

# --- HSL to RGB 変換 (整数演算、精度 x1000) ---
# Arguments: H (0-360), S (0-100), L (0-100)
# Output: "R G B" (0-255)
hsl_to_rgb() {
    local h=$1 s=$2 l=$3

    local s1000=$(( s * 10 ))
    local l1000=$(( l * 10 ))

    # chroma = (1 - |2L - 1|) * S
    local two_l=$(( 2 * l1000 ))
    local abs_val=$(( two_l - 1000 ))
    [ $abs_val -lt 0 ] && abs_val=$(( -abs_val ))
    local chroma=$(( (1000 - abs_val) * s1000 / 1000 ))

    # h' = h / 60
    local h_prime=$(( h * 1000 / 60 ))

    # x = chroma * (1 - |h' mod 2 - 1|)
    local h_mod2=$(( h_prime % 2000 ))
    local abs_x=$(( h_mod2 - 1000 ))
    [ $abs_x -lt 0 ] && abs_x=$(( -abs_x ))
    local x=$(( chroma * (1000 - abs_x) / 1000 ))

    local r1=0 g1=0 b1=0

    if [ $h_prime -lt 1000 ]; then
        r1=$chroma; g1=$x; b1=0
    elif [ $h_prime -lt 2000 ]; then
        r1=$x; g1=$chroma; b1=0
    elif [ $h_prime -lt 3000 ]; then
        r1=0; g1=$chroma; b1=$x
    elif [ $h_prime -lt 4000 ]; then
        r1=0; g1=$x; b1=$chroma
    elif [ $h_prime -lt 5000 ]; then
        r1=$x; g1=0; b1=$chroma
    else
        r1=$chroma; g1=0; b1=$x
    fi

    # m = L - chroma/2
    local m=$(( l1000 - chroma / 2 ))

    # 0-255 に変換してクランプ
    local r=$(( (r1 + m) * 255 / 1000 ))
    local g=$(( (g1 + m) * 255 / 1000 ))
    local b=$(( (b1 + m) * 255 / 1000 ))
    [ $r -lt 0 ] && r=0; [ $r -gt 255 ] && r=255
    [ $g -lt 0 ] && g=0; [ $g -gt 255 ] && g=255
    [ $b -lt 0 ] && b=0; [ $b -gt 255 ] && b=255

    echo "$r $g $b"
}

rgb_to_hex() {
    printf "#%02x%02x%02x" "$1" "$2" "$3"
}

# 相対輝度から適応的に白/黒を返す
adaptive_fg() {
    local r=$1 g=$2 b=$3
    local luminance=$(( (r * 299 + g * 587 + b * 114) / 1000 ))
    if [ "$luminance" -gt 128 ]; then
        echo "colour232"  # black
    else
        echo "colour255"  # white
    fi
}

# --- variant ごとの lightness 定義 ---
#   base:   25% (最暗、ステータスバー背景)
#   light1: 32%
#   light2: 38%
#   light3: 44%
#   light4: 50% (最明)
case "$VARIANT" in
    base)
        read -r r g b <<< "$(hsl_to_rgb "$HUE" "$SATURATION" 25)"
        rgb_to_hex "$r" "$g" "$b"
        ;;
    light1)
        read -r r g b <<< "$(hsl_to_rgb "$HUE" "$SATURATION" 32)"
        rgb_to_hex "$r" "$g" "$b"
        ;;
    light2)
        read -r r g b <<< "$(hsl_to_rgb "$HUE" "$SATURATION" 38)"
        rgb_to_hex "$r" "$g" "$b"
        ;;
    light3)
        read -r r g b <<< "$(hsl_to_rgb "$HUE" "$SATURATION" 44)"
        rgb_to_hex "$r" "$g" "$b"
        ;;
    light4)
        read -r r g b <<< "$(hsl_to_rgb "$HUE" "$SATURATION" 50)"
        rgb_to_hex "$r" "$g" "$b"
        ;;
    fg)
        # light1/light2 背景用の前景色
        read -r r g b <<< "$(hsl_to_rgb "$HUE" "$SATURATION" 38)"
        adaptive_fg "$r" "$g" "$b"
        ;;
    fg_light)
        # light3/light4 背景用の前景色
        read -r r g b <<< "$(hsl_to_rgb "$HUE" "$SATURATION" 50)"
        adaptive_fg "$r" "$g" "$b"
        ;;
    *)
        echo "Usage: $0 <session_name> <base|light1|light2|light3|light4|fg|fg_light>" >&2
        exit 1
        ;;
esac
