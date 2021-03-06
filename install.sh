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
brew install autojump
brew install youtube-dl

# Install Node.js
brew install nvm
nvm install --lts
brew install yarn --without-node

# brew cask applications
brew tap caskroom/cask

# Install Docker
brew cask install docker # Docker Community Edition for macOS
# brew install docker-compose

brew cask install discord
brew cask install kap
brew cask install gimp
brew cask install google-chrome
brew cask install homebrew/cask-versions/google-chrome-canary
brew cask install homebrew/cask-versions/microsoft-remote-desktop-beta
brew cask install iterm2
brew cask install keybase
brew cask install postman
brew cask install slack
brew cask install spectacle
brew cask install spotify
brew cask install vlc
brew cask install visual-studio-code
brew cask install wireshark
brew cask install virtualbox
brew cask install vagrant
brew cask install vagrant-manager
brew cask install zoomus

# Install https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json webpquicklook suspicious-package quicklookase qlvideo

# Install displaylink
brew tap homebrew/cask-drivers
brew cask install displaylink

function add_app_to_dock {
  defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$APP_PATH</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
}

add_app_to_dock "/Applications/iTerm.app"
add_app_to_dock "/Applications/Utilities/Terminal.app"
add_app_to_dock "/Applications/Utilities/Activity Monitor.app"
add_app_to_dock "/Applications/Visual Studio Code.app"
# add_app_to_dock "/Applications/Google Chrome.app"
add_app_to_dock "/Applications/Google Chrome Canary.app"
add_app_to_dock "/Applications/Slack.app"
add_app_to_dock "/Applications/zoom.us.app"
add_app_to_dock "/Applications/Postman.app"
add_app_to_dock "/Applications/Spotify.app"
add_app_to_dock "/Applications/Keybase.app"
killall Dock

# Install XCode for make and friends
hash make || xcode-select --install

# Remove outdated versions from the cellar.
brew cleanup

# Install nifty npm tools

yarn global add yo
yarn global add http-server
yarn global add tldr
yarn global add fkill
yarn global add castnow
yarn global add vtop
yarn global add create-react-app
yarn global add ndb
yarn global add speed-test
yarn global add trash-cli
yarn global add is-up-cli
yarn global add is-online-cli

# Generate an ~/.ssh/id_rsa key-pair
if [ ! -f ~/.ssh/id_rsa ]; then
  ssh-keygen -t rsa -C "$EMAIL" -P '' -f ~/.ssh/id_rsa 
fi

# Allow authentication of 'sudo' commands with Touch ID
if [ $(cat /etc/pam.d/sudo | grep pam_tid | wc -l) = '0' ]
then
  sudo gsed -i '2iauth sufficient pam_tid.so' /etc/pam.d/sudo
fi

# Configure git
git config --global user.signingkey "$GPG_KEY_ID"
git config --global commit.gpgsign true
git config --global user.name "Lucas Azzola"
git config --global user.email "$EMAIL"

# Make some directories
mkdir -p ~/code/azz
mkdir -p ~/Downloads/Installers
mkdir -p ~/Downloads/Artifacts

# Start any boxes in ~/Vagrantfile
vagrant up

echo ""
echo "ALL DONE!"
echo ""
