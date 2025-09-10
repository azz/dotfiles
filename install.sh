#!/usr/bin/env bash +xu

: "${EMAIL}"

# Install homebrew
hash brew || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Don't attempt to update brew (again) for the rest of this session
export HOMEBREW_NO_AUTO_UPDATE=1

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, NOT overwriting the built-in `sed`.
brew install gnu-sed # --with-default-names
# Install Bash 4.
brew install bash
brew install bash-completion2

# Switch to using brew-installed bash as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;

# Install `wget` with IRI support.
brew install wget --with-iri

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install grep
brew install openssh
brew install tmux
brew install gmp

# Install some CTF tools; see https://github.com/ctfs/write-ups.
brew install nmap
brew install sqlmap
brew install ucspi-tcp # `tcpserver` etc.

# Install other useful binaries.
brew install ack
brew install git
brew install git-lfs
brew install imagemagick --with-webp
brew install lynx
brew install tree
brew install htop
brew install btop
brew install httpie
brew install mkcert
brew install graphviz
brew install the_silver_searcher
brew install autojump

# Install Casks
brew install --cask 1password
brew install --cask rancher
brew install --cask ghostty
brew install --cask raycast
brew install --cask slack
brew install --cask visual-studio-code
brew install --cask zed
brew install --cask zoomus

# Install displaylink
# brew tap homebrew/cask-drivers
# brew cask install displaylink

# Install XCode for make and friends
hash make || xcode-select --install

# Remove outdated versions from the cellar.
brew cleanup

# Allow authentication of 'sudo' commands with Touch ID
if [ $(cat /etc/pam.d/sudo | grep pam_tid | wc -l) = '0' ]; then
  sudo gsed -i '2iauth sufficient pam_tid.so' /etc/pam.d/sudo
fi

# Configure git
git config --global user.name "Lucas Azzola"
git config --global user.email "$EMAIL"

# Make some directories
mkdir -p ~/src
mkdir -p ~/Downloads/Installers
mkdir -p ~/Downloads/Artifacts

# Install oh-my-tmux
curl -fsSL "https://github.com/gpakosz/.tmux/raw/refs/heads/master/install.sh#$(date +%s)" | bash


echo ""
echo "ALL DONE!"
echo ""
