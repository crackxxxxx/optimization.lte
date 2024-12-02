#!/system/bin/sh

# Функция для получения состояния устройства (awake, doze или sleep)
get_device_state() {
    # Использование команды dumpsys power для получения состояния устройства
    local power_state=$(dumpsys power | grep "mWakefulness=" | cut -d"=" -f2)
    echo "$power_state"
}

# Список скриптов, которые нужно запустить
SCRIPTS=("/system/bin/sh power_manager.sh" "/system/bin/sh qos_manager.sh" "/system/bin/sh qos_priority.sh")

# Основная логика скрипта
monitor_device_state() {
    local awake_interval=30  # Интервал проверки в активном состоянии (секунд)
    local doze_interval=180  # Интервал проверки в режиме Doze (секунд)
    local sleep_interval=900  # Интервал проверки в спящем режиме (секунд)

    while true; do
        local device_state=$(get_device_state)

        if [ "$device_state" = "Awake" ]; then
            # Устройство в активном состоянии, запускаем все необходимые скрипты
            for script in "${SCRIPTS[@]}"; do
                $script &
            done
            sleep $awake_interval
        elif [ "$device_state" = "Doze" ]; then
            # Устройство в режиме Doze, запускаем все необходимые скрипты
            for script in "${SCRIPTS[@]}"; do
                $script &
            done
            sleep $doze_interval
        else
            # Устройство в спящем режиме, ожидаем немного перед следующей проверкой
            sleep $sleep_interval
        fi
    done
}

monitor_device_state