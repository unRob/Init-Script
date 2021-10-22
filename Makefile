release:
	rm -rf ./dist
	mkdir -p ./dist
	cat src/util.sh <(sed 'd/source//' src/bootstrap.sh) > dist/init.sh
