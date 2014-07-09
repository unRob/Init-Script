#!/bin/bash

function pause(){
	read -p "Presiona enter cuando acabe ese pedo"
}


echo "Vamos a settear madres..."
echo ""


# Cambiar nombre de la compu
function nombre(){
	read -e -p "¿Cómo se llama esta compu? " COMPUTAR_NAME

	COMPUTAR_SUBNET_NAME=`echo $COMPUTAR_NAME | iconv -f utf8 -t us-ascii//TRANSLIT//IGNORE | tr -cd '[[:alnum:]._-]' | awk '{print tolower($0)}'` 
	read -e -p "¿Y, de cariño? (${COMPUTAR_SUBNET_NAME}.local) " SUBNET_NAME

	if [ -n "$SUBNET_NAME" ]; then
		COMPUTAR_SUBNET_NAME=$SUBNET_NAME
	fi

	echo "$COMPUTAR_NAME ($COMPUTAR_SUBNET_NAME)"
	systemsetup -setcomputername $COMPUTAR_NAME
	systemsetup -setlocalsubnetname $COMPUTAR_SUBNET_NAME
}

nombre



echo "Autorizando a Jimi y a Rob descagar tu sistema via SSH"
sudo systemsetup -setremotelogin on


echo "Creando directorios en /usr/local"
sudo mkdir -v /usr/local
sudo chown -R rob:staff /usr/local
mkdir -v /usr/local/bin
mkdir -v /usr/local/var
mkdir -v /usr/local/gems
mkdir -v /usr/local/npm


function sublime_text() {
	echo "Descargando SublimeText 3"
	open "http://www.sublimetext.com/3"
	echo "Copiando licencia de ST al clipboard"
	cat private/sublime.st-license | pbcopy 
	open /Applications/SublimeText.app

	pause

	echo "Copiando instalación de Package Manager a clipboard"
	echo "import urllib.request,os,hashlib; h = '7183a2d3e96f11eeadd761d777e62404' + 'e330c659d4bb41d3bdf022e94cab3cd0'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://sublime.wbond.net/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)
	" | pbcopy
	pause

	echo "Instala estos paquetes:"
	echo <<PACKAGES
	markdownediting
	rsub
	gitgutter
	jshintgutter
	Theme - Soda
	nginx
PACKAGES

	ST_USER_PREFS="~/Library/Application Support/Packages/User/Preferences.sublime-settings"

	echo "Copiando preferencias de ST"
	cp -v config/Preferences.sublime-settings $ST_USER_PREFS

	echo "Symlinkeando subl"
	ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
} 



echo "Descargando iTerm" 
curl -O -L http://iterm2.com/downloads/stable/iTerm2_v1_0_0.zip
unzip iTerm2_v1_0_0.zip -d /Applications/
rm iTerm2_v1_0_0.zip


echo "Descargando DejaVu Mono Sans"
curl -L http://sourceforge.net/projects/dejavu/files/dejavu/2.34/dejavu-fonts-ttf-2.34.tar.bz2/download >> dejavu.tar.bz2
tar xfz dejavu.tar.bz2
cp dejavu-fonts-ttf-2.34/ttf/*.ttf ~/Library/Fonts
rm -rf dejavu.tar.bz2
rm -rf dejavu-fonts-ttf-2.34

echo "Instalando Command Line Tools"
xcode-select -—install
pause



# ZSH
echo "Cambiando el shell a ZSH"
chsh -s /bin/zsh
echo "Instalando Oh My ZSH"
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | ZSH=~/.dotfiles/oh-my-zsh sh

# Dotfiles
echo "Clonando dotfiles"
git clone git@github.com:/unRob/dotfiles.git .dotfiles


echo "Copiando .zshrc"
ln -s .dotfiles/zshrc.dotfile .zshrc
source .zshrc

echo "Copiando dotfiles"
ln -s .dotfiles/*.dotfile .
zmv '(*).dotfile' '.$1'
echo "Instalando settings de iTerm"
cp .dotfiles/com.googlecode.iterm2.plist ~/Library/Preferences/
defaults read com.googlecode.iterm2
killall cfprefsd

open /Applications/iTerm.app
rm -rf ./private

echo "Listo, ahora corre ./config.sh en iTerm"
read -p "Presiona enter para cerrar este pedo"
osascript -e 'tell application "Terminal" to quit'