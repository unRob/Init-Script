#!/bin/bash

echo ""
echo "### INIT SCRIPT ###"
echo ""

echo "Descargando archivos privados..."
# esto lo cree con `tar -cz -f - private | openssl aes-256-cbc -out private.tgz.enc`
curl -s http://rob.mx/private.tgz.enc 2>&1 1 \
    | openssl aes-256-cbc -d \
    | tar xfz -

if [ ! -d "./private" ]; then
	echo "No pude desencriptar el archivo :/"
	exit
fi

mv -v private/ssh ~/.ssh

git clone git@github.com:unRob/Init-Script.git init
cd init && ./start.sh