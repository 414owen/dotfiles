#!/bin/sh

# Wait until the PulseAudio service is available
# (which pipewire-pulse provides)
until pactl info &>/dev/null; do
    sleep 0.1
done

# Now that PipeWire is ready, launch Waybar
waybar -l trace > ~/waybar.log
