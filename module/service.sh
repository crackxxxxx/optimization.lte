#!/system/bin/sh

if [ -f /data/adb/modules/optimization.lte/autostart ]; then
        su -c "qos_priority start"
fi
