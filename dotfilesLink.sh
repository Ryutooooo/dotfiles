for f in .??*
do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".DS_Store" ] && continue
    [ "$f" = ".gitignore" ] && continue
    [ "$f" = ".gitmodules" ] && continue

    ln -snfv "dotfiles"/"$f" "$HOME"/"$f"
done
