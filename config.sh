#!/bin/bash
# Sublime Text

#FILE=$(readlink "$0")
BASEPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function pause(){
    read -p "Presiona enter cuando acabe ese pedo"
}


echo "### Config ###"


echo "Instalando Homebrew"
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew doctor
echo "Instalando ruby, node, git"
brew install ruby node git
echo "Mandando a la verga git viejo de OSX"
sudo mv /usr/bin/git /usr/bin/git.original

echo "Instalando Lunchy"
gem install lunchy

echo "Hay que modificar ENV de sudo..."
echo 'Defaults        env_keep += "GEM_HOME"' | pbcopy
echo "Agrega la línea del clipboard a este pedo y guárdalo"
sudo visudo



# Dropbox
echo "Vas a bajar dropbox"
open https://www.dropbox.com/install



# Nginx + friends
echo "### Nginx ###"
gem install passenger
brew install luajit wget pcre geoip

mkdir -v src && cd src

export LUAJIT_LIB=/usr/local/lib
export LUAJIT_INC=/usr/local/include/luajit-2.0

NGINX_VERSION='1.6.0'
wget http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz
tar xfz nginx-$NGINX_VERSION.tar.gz
wget http://pushmodule.slact.net/downloads/nginx_http_push_module-0.692.tar.gz
tar xfz nginx_http_push_module-0.692.tar.gz
wget http://github.com/gnosek/nginx-upstream-fair/tarball/master --no-check-certificate
tar xfz master
git clone git://github.com/simpl/ngx_http_set_hash.git
git clone git://github.com/simpl/ngx_devel_kit.git
git clone git://github.com/agentzh/set-misc-nginx-module.git
git clone git://github.com/chaoslawful/lua-nginx-module.git
cd nginx-$NGINX_VERSION


echo "Instalando nginx $NGINX_VERSION"
# no-deprecated-declarations porque MD5 en ngx_crypt...
# no-sometimes-uninitialized porque pushmodule
NGINX_LOGS=~/Library/logs/nginx
NGINX_VAR=/usr/local/var/nginx
NGINX_ETC=/usr/local/etc/nginx
PASSENGER_ROOT=$(passenger-config --root)
RUBY_ROOT=$(which ruby)
./configure \
    --with-ld-opt="-L /usr/local/lib" \
    --prefix=/usr/local/nginx \
    --with-cc-opt=-I/usr/local/include \
    --with-cc-opt="-Wno-sometimes-uninitialized -Wno-deprecated-declarations" \
    --conf-path=$NGINX_ETC/nginx.conf \
    --http-log-path=$NGINX_LOGS/nginx/access.log \
    --error-log-path=$NGINX_LOGS/nginx/error.log \
    --http-client-body-temp-path=$NGINX_VAR/body \
    --http-fastcgi-temp-path=$NGINX_VAR/fastcgi \
    --http-proxy-temp-path=$NGINX_VAR/proxy \
    --lock-path=$NGINX_VAR/nginx.lock \
    --pid-path=$NGINX_VAR/nginx.pid \
    --with-http_geoip_module \
    --with-http_gzip_static_module \
    --with-http_realip_module \
    --with-http_stub_status_module \
    --with-http_ssl_module \
    --with-http_sub_module \
    --with-pcre \
    --add-module=../ngx_devel_kit \
    --add-module=../gnosek-nginx-upstream-fair-a18b409 \
    --add-module=../nginx_http_push_module-0.692 \
    --add-module=../lua-nginx-module \
    --add-module=../ngx_http_set_hash \
    --add-module=../set-misc-nginx-module \
    --add-module=$PASSENGER_ROOT/ext/nginx

make
mkdir -p ~/Library/logs/nginx
make install
ln -sv /usr/local/nginx/sbin/nginx /usr/local/bin/

echo "Instalando launchdaemon..."
sudo cp -v $BASEPATH/config/org.nginx.plist /Library/LaunchDaemons/org.nginx.plist
sudo chown root:wheel /Library/LaunchDaemons/org.nginx.plist
echo "Pifando nginx.conf"
cp -v $BASEPATH/config/nginx.conf /usr/local/etc/nginx/nginx.conf
sed -i 's|NGINX_VAR|$NGINX_VAR|g' /usr/local/etc/nginx/nginx.conf
sed -i 's|NGINX_LOGS|$NGINX_LOGS|g' /usr/local/etc/nginx/nginx.conf
sed -i 's|NGINX_ETC|$NGINX_ETC|g' /usr/local/etc/nginx/nginx.conf
sed -i 's|PASSENGER_ROOT|$PASSENGER_ROOT|g' /usr/local/etc/nginx/nginx.conf
sed -i 's|RUBY_ROOT|$RUBY_ROOT|g' /usr/local/etc/nginx/nginx.conf



# dnsmasq
echo "instalando dnsmasq (resolver dominios .dev)"
brew install dnsmasq
cp -v /usr/local/opt/dnsmasq/dnsmasq.conf.example /usr/local/etc/dnsmasq.conf
sudo mkdir -pv /etc/resolver
sudo tee /etc/resolver/dev >/dev/null <<EOF
nameserver 127.0.0.1
EOF
echo "address=/dev/127.0.0.1" >> /usr/local/etc/dnsmasq.conf



# MongoDB
echo "Instalando MongoDB"
brew install mongo
ln -sfv /usr/local/opt/mongodb/*.plist ~/Library/LaunchAgents



# Github for Mac
echo "Instalando Github for Mac"
wget https://central.github.com/mac/latest -O ~/Downloads/github-mac.zip
unzip ~/Downloads/github-mac.zip -d /Applications
open /Applications/Github.app

# Skype
echo "Bajando Skype"
open http://www.skype.com/en/download-skype/skype-for-mac/downloading/

# Chrome, Firefox
echo "Bajando Chrome"
open https://www.google.com/intl/en/chrome/browser/thankyou.html
echo "Bajando Firefox 30.0"
open https://download.mozilla.org/?product=firefox-30.0-SSL&os=osx&lang=en-US

# Transmission
echo "Bajando Transmission"
open https://www.transmissionbt.com/download/

# Steam
echo "Bajando Steam"
wget http://media.steampowered.com/client/installer/steam.dmg -O ~/Downloads/steam.dmg
open ~/Downloads/steam.dmg


# stuff
echo "Instalando ffmepg, redis, icu4c, pkgconfig ghostscript imagemagickick"
brew install ffmpeg redis icu4c
ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents
# sin esta madre no jala imagemagick en PHP, Ruby
brew install pkgconfig
brew install ghostscript
brew install imagemagick


# PHP
brew tap homebrew/dupes
brew tap homebrew/versions
brew tap homebrew/homebrew-php
brew install mysql
brew install php55 --with-fpm --with-homebrew-curl --with-homebrew-libxslt --with-homebrew-openssl --with-imap --with-intl --with-libmysql --with-bz2
brew install php55-intl php55-xdebug
cp /usr/local/Cellar/php55/5.5.14/homebrew.mxcl.php55.plist ~/Library/LaunchAgents/

PHP_INI=/usr/local/etc/php/5.5/php.ini

echo "Siguiendo las instrucciones para descagar PEAR"
chmod -R ug+w /usr/local/Cellar/php55/5.5.14/lib/php
pear config-set php_ini $PHP_INI
echo "Configurando PHP"
sed -i 's/\;date\.timezone\ =/date\.timezone\ =\ America\/Mexico_City/g' $PHP_INI
sed -i 's/\;default_charset\ =\ "UTF-8"/default_charset\ =\ "UTF-8"/g' $PHP_INI
sed -i 's/error_reporting\ =\ E_ALL/error_reporting\ =\ E_ALL\ &\ ~E_DEPRECATED\ &\ ~E_STRICT\ &\ ~E_NOTICE/g' $PHP_INI
sed -i 's/short_open_tag\ =\ Off/short_open_tag\ =\ On/g' $PHP_INI
echo "Instalando paquetes de PHP"
pecl install pecl_http mongo redis imagick
pear channel-discover pear.swiftmailer.org && pear install swift/Swift
