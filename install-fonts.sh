#!/bin/bash

the_fonts_dir=$(pwd)
echo "the_fonts_dir: $the_fonts_dir"

find_command="find \"$the_fonts_dir\" \( -name '*.[o,t]tf' -or -name '*.pcf.gz' \) -type f -print0"

# MacOS
font_dir="$HOME/Library/Fonts"

echo -e "Run: $find_command | xargs -0 -I % cp \"%\" \"$font_dir/\"\n"

# Copy all fonts to user fonts directory
echo "Copying fonts..."

# printing
eval $find_command | xargs -0 -I %

eval $find_command | xargs -0 -I % cp "%" "$font_dir/"

echo -e "\nAll fonts have been installed to $font_dir"
