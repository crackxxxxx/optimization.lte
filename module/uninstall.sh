#!/system/bin/sh

   MODDIR=/data/adb/modules/optimize.lte

   # Основная функция для удаления всех изменений
   main() {
       # Останавливаем запущенные скрипты
       su -c "
           pkill -f $MODDIR/scripts/qos_manager.sh
           pkill -f $MODDIR/scripts/power_manager.sh
       "
   }

   # Выполнение основной функции
   main
