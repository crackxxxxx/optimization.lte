#!/system/bin/sh

# Копируем скрипты в нужную директорию
cp -f $MODPATH/system/bin/power_manager.sh /system/bin/power_manager.sh
chmod 0755 /system/bin/power_manager.sh

cp -f $MODPATH/system/bin/qos_manager.sh /system/bin/qos_manager.sh
chmod 0755 /system/bin/qos_manager.sh

# Запускаем скрипты
/system/bin/power_manager.sh &
/system/bin/qos_manager.sh &