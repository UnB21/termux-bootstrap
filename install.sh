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

mapfile -t packages < <(
    grep -v '^#' packages.txt | sed '/^$/d'
)

echo "Packages to install:"
printf '  %s\n' "${packages[@]}"

echo

pkg install -y "${packages[@]}"

echo
echo "Termux bootstrap base installation complete."

echo
echo "Next steps:"
echo "- Configure Git"
echo "- Authenticate GitHub CLI"
echo "- Clone projects"
echo "- Restore personal configuration files"
