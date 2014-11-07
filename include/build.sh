#!/bin/bash


build(){

	build_autogen
	build_configure
	build_make
	
	if [ "${BUILD_AS_ROOT}" = true ]; then
		su_build_install
	else
		build_install
	fi
	
	build_finishinstall
}


build_autogen() {
	
	cd "${SOURCE_DIR}/${DIR_NAME}"
	
	if ! [ -f "${SOURCE_DIR}/${DIR_NAME}/configure" ]; then
		echo -n "  Autogen ${NAME}... "
		./autogen.sh >$LOG_FILE 2>&1
		is_error "$?"
	fi
	
	cd $BASE_DIR
}


build_configure() {

	cd "${SOURCE_DIR}/${DIR_NAME}"

	if [ "$ARG_CONF_HELP" == true ]; then
		./configure --help
		exit
	elif [ "$ARG_CONF_SHOW" == true ]; then
		./configure ${ARGS[@]}
		exit
	fi
	
	echo -n "  Configure ${NAME}... "
	#./configure --prefix="${SYSROOT_DIR}" ${ARGS[@]} >$LOG_FILE 2>&1

	./configure --prefix="${SYSROOT_DIR}" ${ARGS[@]} 2>&1
	is_error "$?"

	cd $BASE_DIR
}


build_make() {

	cd "${SOURCE_DIR}/${DIR_NAME}"

	echo -n "  Make ${NAME}... "
	make >$LOG_FILE 2>&1
	is_error "$?"

	cd $BASE_DIR
}


build_install() {

	cd "${SOURCE_DIR}/${DIR_NAME}"
	
	echo -n "  Install ${NAME}... "
	make install >$LOG_FILE 2>&1
	is_error "$?"

	cd $BASE_DIR
}


su_build_install() {

	cd "${SOURCE_DIR}/${DIR_NAME}"
	
	echo -n "  Install ${NAME}... "
	sudo make install >$LOG_FILE 2>&1
	is_error "$?"

	cd $BASE_DIR
}


build_finishinstall() {

	rm -f $LOG_FILE
}