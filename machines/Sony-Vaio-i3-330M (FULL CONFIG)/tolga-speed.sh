#!/bin/bash

# tolga
# ./tolga-speed.sh sda

# -----------------------------------------------------
# Check if the correct number of arguments is provided
# -----------------------------------------------------

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <device>"
    exit 1
fi

device=$1

# -----------------------------------------------------
# Check if the device exists
# -----------------------------------------------------

if [ ! -e "/sys/block/$device" ]; then
    echo "Device $device not found."
    exit 1
fi
# -----------------------------------------------------
# Set the I/O scheduler to "deadline"
# -----------------------------------------------------

echo "Setting I/O scheduler to 'deadline' for $device"
echo "deadline" | sudo tee "/sys/block/$device/queue/scheduler"

# -----------------------------------------------------
# Set vm.dirty_ratio and vm.dirty_background_ratio
# -----------------------------------------------------

echo "Setting vm.dirty_ratio to 5"
echo 5 | sudo tee /proc/sys/vm/dirty_ratio

echo "Setting vm.dirty_background_ratio to 3"
echo 3 | sudo tee /proc/sys/vm/dirty_background_ratio

# -----------------------------------------------------
# Set block read-ahead buffer
# -----------------------------------------------------

echo "Setting block read-ahead buffer to 2048"
sudo blockdev --setra 2048 "/dev/$device"

echo "Configuration completed for $device."
