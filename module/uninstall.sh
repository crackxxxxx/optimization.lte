#!/system/bin/sh

# Пути к установленным скриптам
SCRIPTS=("/system/bin/qos_manager.sh" "/system/bin/power_manager.sh" "/system/bin/qos_priority.sh" "/system/bin/monitor_device_state.sh")

for script in "${SCRIPTS[@]}"; do
    if [ -f "$script" ]; then
        echo "Removing script: $script"
        rm "$script"
    fi
done

echo "Scripts removed successfully."