#!/data/data/com.termux/files/usr/bin/bash

set -e

VERSION=$(cat VERSION)

echo "================================="
echo " Termux Bootstrap"
echo " Version: $VERSION"
echo "================================="

echo
echo "Updating Termux packages..."

pkg update -y
pkg upgrade -y

echo
echo "Installing required packages..."

while read -r package; do
    [[ -z "$package" || "$package" =~ ^# ]] && continue

    echo "Installing: $package"
    pkg install -y "$package"
done < packages.txt

echo
echo "Termux bootstrap base installation complete."

echo
echo "Next steps:"
echo "- Configure Git"
echo "- Authenticate GitHub CLI"
echo "- Clone projects"
echo "- Restore personal configuration files"
