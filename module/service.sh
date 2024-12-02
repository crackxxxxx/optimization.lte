#!/system/bin/sh

# Копируем скрипты в нужную директорию
cp -f $MODPATH/system/bin/power_manager.sh /system/bin/power_manager.sh
chmod 0755 /system/bin/power_manager.sh

cp -f $MODPATH/system/bin/qos_manager.sh /system/bin/qos_manager.sh
chmod 0755 /system/bin/qos_manager.sh

cp -f $MODPATH/system/bin/qos_priority.sh /system/bin/qos_priority.sh
chmod 0755 /system/bin/qos_priority.sh

cp -f $MODPATH/system/bin/monitor_device_state.sh /system/bin/monitor_device_state.sh
chmod 0755 /system/bin/monitor_device_state.sh

# Запускаем скрипты
/system/bin/monitor_device_state.sh &
/system/bin/qos_priority.sh &