#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
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

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install grep
brew install openssh
brew install screen
brew install php
brew install gmp

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# Install some CTF tools; see https://github.com/ctfs/write-ups.
brew install aircrack-ng
brew install bfg
brew install binutils
brew install binwalk
brew install cifer
brew install dex2jar
brew install dns2tcp
brew install fcrackzip
brew install foremost
brew install hashpump
brew install hydra
brew install john
brew install knock
brew install netpbm
brew install nmap
brew install pngcheck
brew install socat
brew install sqlmap
brew install tcpflow
brew install tcpreplay
brew install tcptrace
brew install ucspi-tcp # `tcpserver` etc.
brew install xpdf
brew install xz

# Install other useful binaries.
brew install ack
#brew install exiv2
brew install git
brew install git-lfs
brew install imagemagick --with-webp
brew install lua
brew install lynx
brew install p7zip
brew install pigz
brew install pv
brew install rename
brew install rlwrap
brew install ssh-copy-id
brew install tree
brew install vbindiff
brew install zopfli
brew install htop
brew install hub
brew install httpie
brew install mkcert
brew install mercurial
brew install graphviz
brew install the_silver_searcher

# Install Node.js
brew install nvm
nvm install --lts
brew install yarn --without-node

# Install Docker
brew install docker
brew install docker-compose

# brew cask applications
brew tap caskroom/cask

brew cask install discord
brew cask install kap
brew cask install gimp
brew cask install google-chrome
brew cask install homebrew/cask-versions/google-chrome-canary
brew cask install homebrew/cask-versions/microsoft-remote-desktop-beta
brew cask install slack
brew cask install spotify
brew cask install vlc
brew cask install wireshark
brew cask install visual-studio-code
brew cask install zoomus
brew cask install virtualbox
brew cask install vagrant
brew cask install vagrant-manager

vagrant up

function add_app_to_dock {
  defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$APP_PATH</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
}

add_app_to_dock "/Applications/Google Chrome.app"
add_app_to_dock "/Applications/Google Chrome Canary.app"
add_app_to_dock "/Applications/Slack.app"
add_app_to_dock "/Applications/zoom.us.app"
add_app_to_dock "/Applications/Visual Studio Code.app"
add_app_to_dock "/Applications/Spotify.app"
add_app_to_dock "/Applications/Utilities/Terminal.app"
add_app_to_dock "/Applications/Utilities/Activity Monitor.app"
killall Dock

# Install XCode for make and friends
xcode-select --install

# Remove outdated versions from the cellar.
brew cleanup
