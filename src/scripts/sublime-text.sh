PACKAGE_CONTROL="https://packagecontrol.io/Package%20Control.sublime-package"
installed_packages="${HOME}/Library/Application Support/Sublime Text 3/Installed Packages/"

curl "$PACKAGE_CONTROL" > "${installed_packages}/Package Control.sublime-package"

if ! command -v subl; then
  ln -sfv "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
fi
