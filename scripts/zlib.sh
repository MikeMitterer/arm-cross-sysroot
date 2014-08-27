#!/bin/bash

TITLE="zlib - Compressing File-I/O Library"

build_zlib(){

	cd $WORKING_DIR/src
	
	NAME=zlib-1.2.8
	ARCHIV=$NAME.tar.gz
	URL=http://zlib.net/$ARCHIV
	
	# Download if archiv not exist 
	if ! [[ -f "$WORKING_DIR/src/$ARCHIV" || -d "$WORKING_DIR/src/$NAME" ]]; then
		echo "Download $ARCHIV"
		curl -O $URL
	fi
	
	# Extract archiv is dir not exists
	if ! [ -d "$WORKING_DIR/src/$NAME" ]; then
	
		echo -n "Extracting $NAME... "
		tar xzf $ARCHIV
		echo "done"

	fi
	
	cd $WORKING_DIR/src/$NAME
	
	echo -n "Configure $NAME... "
	if ! [ -f "$WORKING_DIR/src/$NAME/.configured" ]; then

		CC=$CFG_HOST-gcc ./configure --prefix=$PREFIX >/dev/null 2>&1 || exit 1
		touch $WORKING_DIR/src/$NAME/.configured
		echo "done"
		
	else 
		echo "skipped"
	fi
	
	echo -n "Make $NAME... "
	if ! [ -f "$WORKING_DIR/src/$NAME/.made" ]; then
		
		make >/dev/null 2>&1 || exit 1
		touch $WORKING_DIR/src/$NAME/.made
		echo "done"
		
	else 
		echo "skipped"
	fi
	
	echo -n "Install $NAME... "
	if ! [ -f "$WORKING_DIR/src/$NAME/.installed" ]; then
		
		make install >/dev/null 2>&1 || exit 1
		touch $WORKING_DIR/src/$NAME/.installed
		echo "done"
		
	else 
		echo "skipped"
	fi	
	
	cd $WORKING_DIR
}
