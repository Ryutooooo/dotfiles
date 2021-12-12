#!/bin/bash

mkdir -p ~/.config
mkdir -p ~/.config/nvim

for f in .??*
do
  [ "$f" = ".git" ] && continue
  [ "$f" = ".DS_Store" ] && continue
  [ "$f" = ".gitignore" ] && continue
  [ "$f" = ".gitmodules" ] && continue
  [ "$f" = "init.vim" ] && continue
  [ "$f" = ".alacritty.yml" ] && continue
  [ "$f" = "starship.toml" ] && continue

  ln -snfv `pwd`/"$f" "$HOME"/"$f"
done

ln -snfv `pwd`/git-completion.bash "$HOME"/git-completion.bash
ln -snfv `pwd`/init.vim "$HOME"/.config/nvim/init.vim
ln -snfv `pwd`/starship.toml "$HOME"/.config/starship.toml
ln -snfv `pwd`/.alacritty.yml "$HOME"/.config/alacritty/alacritty.yml
