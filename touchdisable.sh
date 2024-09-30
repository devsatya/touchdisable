#!/bin/bash

# Function to find the device ID based on the device name
find_device_id() {
    device_name="$1"

    # Use grep to find the device name in the xinput list output
    device_id=$(xinput list | grep -oP "ELAN Touchscreen.*id=\K\d+")
    #device_id=$(xinput list | grep -A 5 "Virtual core pointer:" | grep "ELAN Touchscreen")

    # Check if device ID was found
    if [[ -z "$device_id" ]]; then
        echo "Device not found: $device_name"
        return 1
    fi

    echo "$device_id"
}

# Get the device name from the user
#echo "Enter the device name:"
#read device_name

# Find the device ID
device_id=$(find_device_id "$device_name")
device_name=$(xinput list | grep -oP "ELAN Touchscreen")
echo "Device Name: $device_name, Device ID: $device_id"
echo " your $device_name id  :$device_id"

# Check if device ID was found
if [[ $? -eq 0 ]]; then
    # Disable the device
    xinput disable "$device_id"
    echo "Device disabled: $device_name"
fi