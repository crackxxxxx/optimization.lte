   #!/system/bin/sh

   MODDIR=/data/adb/modules/optimize.lte

   # Функция для установки системных свойств из system.prop
   apply_system_properties() {
       su -c "
           while IFS= read -r line; do
               [[ \"$line\" =~ ^\#.*$ || -z \"$line\" ]] && continue
               setprop $(echo \"$line\" | tr '=' '\n')
           done < $MODDIR/system.prop
       "
   }

   # Основная функция для применения всех изменений
   main() {
       # Применение системных свойств
       apply_system_properties

       # Запуск установленных скриптов
       su -c "$MODDIR/scripts/monitor_device_state.sh" &
       su -c "$MODDIR/scripts/qos_priority.sh" &
   }

   # Выполнение основной функции
   main
