#!/bin/bash
# reset-audio.sh
# Script to reset ALSA, PulseAudio, and PipeWire on Ubuntu

echo "[*] Stopping PipeWire and related services..."
systemctl --user stop pipewire.service pipewire-pulse.service wireplumber.service

echo "[*] Killing leftover audio processes..."
killall -q pipewire pipewire-pulse wireplumber pulseaudio 2>/dev/null

echo "[*] Unloading ALSA modules..."
sudo alsa force-unload 2>/dev/null
sudo alsa force-reload

echo "[*] Clearing PulseAudio state..."
rm -rf ~/.config/pulse
rm -rf ~/.pulse*

echo "[*] Restarting PipeWire services..."
systemctl --user start pipewire.service pipewire-pulse.service wireplumber.service

echo "[*] Restarting ALSA..."
sudo alsa force-reload

echo "[*] Done. You may need to log out and back in if audio devices still don’t appear."

