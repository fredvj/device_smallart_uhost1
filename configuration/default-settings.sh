#!/system/xbin/busybox sh

# Copyright (C) 2013, fredvj
#
# Insert values that cannot be set from an overlay directly into the database

# set -x

SQLCMD=/system/xbin/sqlite3
DATABASE=/data/data/com.android.providers.settings/databases/settings.db

# Make sure we just set the default once during initial setup
INITIALIZED=`$SQLCMD $DATABASE "select value from system where name='smart_tv_initialized';"`

# Check for errors

if [ "$?" != "0" ]
then
	echo "Failed to initialize default for Smallart Uhost1 - cannot talk to database"
	exit 1
fi

if [ "$INITIALIZED" = "" ]
then
	echo "Initializing defaults for Smallart Uhost1"

	# Table 'system'

	$SQLCMD $DATABASE "insert or replace into system(name, value) values('stay_on_while_plugged_in', '1');"
	$SQLCMD $DATABASE "insert or replace into system(name, value) values('time_12_24', '24');"
	$SQLCMD $DATABASE "insert or replace into system(name, value) values('status_bar_battery', '2');"
	$SQLCMD $DATABASE "insert or replace into system(name, value) values('expanded_widget_buttons_tablet', 'pref_bluetooth_toggle\|pref_wifi_toggle\|pref_sound_toggle');"
	$SQLCMD $DATABASE "insert or replace into system(name, value) values('notification_sound', 'content://media/internal/audio/media/59');"
	$SQLCMD $DATABASE "insert or replace into system(name, value) values('mock_location', '0');"

	# Table 'secure'

	$SQLCMD $DATABASE "insert or replace into secure(name, value) values('lockscreen.disabled', '1');"

	# Write back flag - init complete

	$SQLCMD $DATABASE "insert or replace into system(name, value) values('smart_tv_initialized', '1');"
else
	echo "Defaults for Smallart Uhost1 are already initialized"
fi

