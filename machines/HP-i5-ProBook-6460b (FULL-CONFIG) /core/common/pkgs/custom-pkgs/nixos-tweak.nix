{ config, pkgs, lib, ... }:

let

  nixos-tweak = pkgs.writeScriptBin "nixos-tweak" ''
    #!/bin/bash

    # Personal nixos-tweaker
    # Tolga Erok. ¯\_(ツ)_/¯
    # 5/10/23

    # Automatic detection of the primary device
    device=$(lsblk -o NAME,TYPE -nr | awk '$2 == "disk" {print $1; exit}')

    # Check if a valid device was found
    if [ -z "$device" ]; then
        echo "No valid device found."
        exit 1
    fi

    echo "Detected device: $device"

    # Determine if the device is an SSD or HDD
    if [[ $(cat "/sys/block/$device/queue/rotational") -eq 1 ]]; then
        device_type="HDD"

        # Set the I/O scheduler to "deadline" for HDDs
        echo -e "\e[97mSetting I/O scheduler to 'deadline' for $device\e[0m"
        echo "deadline" | sudo tee "/sys/block/$device/queue/scheduler"

        # Set block read-ahead buffer for HDDs
        echo -e "\e[97mSetting block read-ahead buffer to 2048 for $device\e[0m"
        sudo blockdev --setra 2048 "/dev/$device"
    else
        device_type="SSD"

        # Set the I/O scheduler to "none" for SSDs
        echo -e "\e[97mSetting I/O scheduler to 'none' for $device\e[0m"
        echo "none" | sudo tee "/sys/block/$device/queue/scheduler"

        # Enable TRIM (discard) for SSDs
        echo -e "\e[97mEnabling TRIM for $device\e[0m"
        sudo fstrim -v /
    fi

    # Get the total RAM
    total_ram=$(free -m | awk '/^Mem:/{print $2}')
    echo -e "\e[93mDetected RAM: $total_ram MB\e[0m"

    # Set vm.dirty_ratio and vm.dirty_background_ratio based on RAM amount
    if [ "$total_ram" -gt 64000 ]; then
        swappiness=5
    elif [ "$total_ram" -gt 32000 ]; then
        swappiness=10
    elif [ "$total_ram" -gt 16000 ]; then
        swappiness=20
    elif [ "$total_ram" -gt 8000 ]; then
        swappiness=40
    else
        swappiness=60
    fi

    echo -e "\e[93mSetting swappiness to $swappiness\e[0m"
    sudo sysctl -w vm.swappiness=$swappiness

    # Reload systemd services to apply swappiness changes
    echo -e "\e[93mReloading systemd services for swappiness changes\e[0m"
    sudo systemctl daemon-reload

    echo "Configuration completed for $device (Device Type: $device_type)."

  '';

in {

  #---------------------------------------------------------------------
  # Type: nixos-tweak in terminal to execute above bash script
  #---------------------------------------------------------------------

  environment.systemPackages = [ nixos-tweak ];

}
