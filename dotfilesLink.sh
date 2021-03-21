#!/bin/bash

for f in .??*
do
  [ "$f" = ".git" ] && continue
  [ "$f" = ".DS_Store" ] && continue
  [ "$f" = ".gitignore" ] && continue
  [ "$f" = ".gitmodules" ] && continue
  [ "$f" = "starship.toml" ] && continue

  ln -snfv `pwd`/"$f" "$HOME"/"$f"
done

ln -snfv `pwd`/starship.toml "$HOME"/.config/starship.toml
