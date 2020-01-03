for f in .??*
do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".DS_Store" ] && continue
    [ "$f" = ".gitignore" ] && continue
    [ "$f" = ".gitmodules" ] && continue
    [ "$f" = "starship.toml" ] && continue

    ln -snfv "dotfiles"/"$f" "$HOME"/"$f"
done

ln -snfv "$HOME"/"dotfiles"/starship.toml "$HOME"/.config/starship.toml
