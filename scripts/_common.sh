#!/bin/bash

#=================================================
# COMMON VARIABLES AND CUSTOM HELPERS
#=================================================

myynh_install() {
	# Patch source to ensure .env is considered in building
	#sed -i "1i import 'dotenv/config';" "$install_dir/svelte.config.js"

	# Create needed directories
	[[ -d "/var/log/$app" ]] || mkdir -p "/var/log/$app"
	[[ -d "$data_dir/uploads" ]] || mkdir -p "$data_dir/uploads"

	# Install with npm
	pushd $install_dir
		ynh_hide_warnings ynh_exec_as_app npm install
		ynh_hide_warnings ynh_exec_as_app npm run build
	popd
}

# Set permissions
myynh_set_permissions () {
	chown -R $app: "$install_dir"
	chmod u=rwx,g=rx,o= "$install_dir"
	chmod -R o-rwx "$install_dir"

	chown -R $app: "$data_dir"
	chmod u=rwx,g=rx,o= "$data_dir"
	chmod -R o-rwx "$data_dir"

	chown -R $app: "/var/log/$app"
	chmod u=rwx,g=rx,o= "/var/log/$app"
	chmod -R o-rwx "/var/log/$app"
}
