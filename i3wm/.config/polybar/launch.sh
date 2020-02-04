#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config
export TRAY_POS=right
for i in $(polybar -m | awk -F: '{print $1}'); do
    MONITOR=$i polybar default &
    unset TRAY_POS
done

echo "Polybar launched..."
