#!/system/xbin/busybox sh

# Copyright (C) 2013, fredvj
#
# Insert values that cannot be set from an overlay directly into the database

SQLCMD=/system/xbin/sqlite3
DATABASE=/data/data/com.android.providers.settings/databases/settings.db

$SQLCMD $DATABASE "insert or replace into system(name, value) values('stay_on_while_plugged_in', '1')";
$SQLCMD $DATABASE "insert or replace into system(name, value) values('time_12_24', '24')";
$SQLCMD $DATABASE "insert or replace into system(name, value) values('status_bar_battery', '2')";
$SQLCMD $DATABASE "insert or replace into system(name, value) values('expanded_widget_buttons_tablet', 'pref_bluetooth_toggle\|pref_wifi_toggle\|pref_sound_toggle')";
$SQLCMD $DATABASE "insert or replace into system(name, value) values('notification_sound', 'content://media/internal/audio/media/59')";
$SQLCMD $DATABASE "insert or replace into system(name, value) values('mock_location', '0')";

$SQLCMD $DATABASE "insert or replace into secure(name, value) values('lockscreen.disabled', '1')";

