# Set source and target directories.  
echo "Installing fonts."


# Install a collection of font directories that are in a parent directory.
# If a second parameter of "otf" is passed, only install otf fonts.
function install {
  local font_dir=$1

  local font_type 
  if [[ $2 == "otf" ]]; then
    font_type="-name '*.otf'"
  else
    font_type="-name '*.[o,t]tf' -or -name '*.pcf.gz'"
  fi 

  echo "Installing fonts in ${font_dir}"
  local find_command="find \"${font_dir}\" \( ${font_type} \) -type f -print0"
  eval ${find_command} | xargs -0 -I % cp "%" "${SYSTEM_FONT_DIR}/"

  # Reset font cache on Linux
  if [[ -n `which fc-cache` ]]; then
    fc-cache -f ${font_dir}
  fi
}

function main {
  if [[ -z ${DOTFILES+x} ]]; then
    DIR="${DOTFILES}"
  else
    DIR=$( cd "$( dirname "$0" )" && pwd )
  fi

  if [[ `uname` == 'Darwin' ]]; then
    # MacOS
    SYSTEM_FONT_DIR="${HOME}/Library/Fonts"
  else
    # Linux
    SYSTEM_FONT_DIR="${HOME}/.fonts"
    mkdir -p ${font_dir}
  fi

  echo "Running powerline fonts install script."
  bash "${DIR}/../deps/powerline-fonts/install.sh"

  # Install the Hack font.
  echo "Installing Hack font."
  install "${DIR}/../deps/vendor/hack-font/" "otf"
  # Install Office Code Pro
  echo "Installing Office Code Pro font."
  install "${DIR}/../deps/office-code-pro/Fonts" "otf"

  echo "All fonts installed to $font_dir"
}

main
