#!/bin/bash

URL="http://ftp.gnome.org/pub/GNOME/sources/libsoup/2.40/libsoup-2.40.3.tar.xz"

DEPEND=()

ARGS=(
	"--host=${HOST}"
	"--sbindir=${BASE_DIR}/tmp/sbin"
	"--libexecdir=${BASE_DIR}/tmp/libexec"
	"--sysconfdir=${BASE_DIR}/tmp/etc"
	"--sharedstatedir=${BASE_DIR}/tmp/com"
	"--localstatedir=${BASE_DIR}/tmp/var"
	"--datarootdir=${BASE_DIR}/tmp/share"
	"--disable-glibtest"
	"--disable-gtk-doc"
	"--disable-nls"
	"--disable-tls-check"
	"--without-gnome"
)

get_names_from_url
installed "libsoup-2.4.pc"

if [ $? == 1 ]; then
	
	if [ -f "${SYSROOT_DIR}/bin/glib-genmarshal" ]; then 
		mv "${SYSROOT_DIR}/bin/glib-genmarshal" "${SYSROOT_DIR}/bin/glib-genmarshal_bak"
	fi
	
	get_download
	extract_tar
	build

	if [ -f "${SYSROOT_DIR}/bin/glib-genmarshal_bak" ]; then 
		mv "${SYSROOT_DIR}/bin/glib-genmarshal_bak" "${SYSROOT_DIR}/bin/glib-genmarshal"
	fi

fi
