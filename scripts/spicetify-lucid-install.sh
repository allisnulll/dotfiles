#!/bin/sh

# https://github.com/sanoojes/Spicetify-Lucid/blob/main/install/install.sh
# Using commit right befor 2.1 (breaking change for me)

set -e

# Download URL
theme_url="https://raw.githubusercontent.com/sanoojes/Spicetify-Lucid/50f590032f44ea0b0e5246d407a5dcfea39c733a/src"

# Setup directories to download to
spice_dir="$(dirname "$(spicetify -c)")"
theme_dir="${spice_dir}/Themes"

# Make directories if needed
mkdir -p "${theme_dir}/Lucid"

# Download latest tagged files into correct director
echo "Downloading Lucid..."
curl --silent --output "${theme_dir}/Lucid/color.ini" "${theme_url}/color.ini"
curl --silent --output "${theme_dir}/Lucid/user.css" "${theme_url}/user.css"
curl --silent --output "${theme_dir}/Lucid/theme.js" "${theme_url}/theme.js"
echo "Done"

# Apply theme
echo "Applying theme"
spicetify config current_theme Lucid color_scheme dark
spicetify config inject_css 1 replace_colors 1 overwrite_assets 1 inject_theme_js 1
spicetify apply

echo "All done!"
