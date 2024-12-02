#!/system/bin/sh

# Пути к системным файлам
SYSTEM_PROP_FILE="/system/build.prop"
SYSTEM_ETC_PROP_FILE="/system/etc/prop.default"

# Константы приоритетов
PRIORITY_NORMAL="normal"
PRIORITY_HIGH="high"
PRIORITY_LOW="low"
PRIORITY_CLASS_MAX=7
PRIORITY_CLASS_MIN=0

# Функция для получения состояния устройства (awake, doze или sleep)
get_device_state() {
    # Использование команды dumpsys power для получения состояния устройства
    local power_state=$(dumpsys power | grep "mWakefulness=" | cut -d"=" -f2)
    echo "$power_state"
}

get_battery_level() {
    # Получение текущего уровня заряда батареи
    local battery_level=$(...)
    echo "$battery_level"
}

set_network_priority() {
    local priority=$1
    local priority_class=$2
    # Установка приоритетов в файлах system.prop и prop.default
    echo "net.qos.default_priority=$priority" >> $SYSTEM_PROP_FILE
    echo "net.qos.default_priority=$priority" >> $SYSTEM_ETC_PROP_FILE
    echo "net.qos.default_class=$priority_class" >> $SYSTEM_PROP_FILE
    echo "net.qos.default_class=$priority_class" >> $SYSTEM_ETC_PROP_FILE
}

optimize_network_priority() {
    # Получение текущего уровня заряда батареи
    local battery_level=$(get_battery_level)

    # Установка приоритетов в зависимости от уровня заряда
    if [[ $battery_level -gt 80 ]]; then
        set_network_priority $PRIORITY_HIGH $((PRIORITY_CLASS_MAX))
    elif [[ $battery_level -gt 60 ]]; then
        set_network_priority $PRIORITY_HIGH $((PRIORITY_CLASS_MAX-1))
    elif [[ $battery_level -gt 40 ]]; then
        set_network_priority $PRIORITY_NORMAL $((PRIORITY_CLASS_MAX/2))
    elif [[ $battery_level -gt 20 ]]; then
        set_network_priority $PRIORITY_LOW $((PRIORITY_CLASS_MIN+2))
    else
        set_network_priority $PRIORITY_LOW $PRIORITY_CLASS_MIN
    fi
}

# Основной цикл
while true; do
    local device_state=$(get_device_state)

    if [ "$device_state" = "Awake" ]; then
        optimize_network_priority
        sleep 1800  # Проверка каждые 30 минут
    else
        sleep 3600  # Проверка каждый час, если устройство в Doze или Sleep
    fi
done