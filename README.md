<div align="center">
  <h1 style="font-size: 24px; color: blue;">My NixOs 23.05 environment, KDE & Nvidia, AMD && Intel</h1>
</div>

```bash
sudo nix-channel --add https://channels.nixos.org/nixos-23.11 nixos
sudo nixos-rebuild boot --upgrade
```
* You probably get some errors and warnings here that you need to take care off
* Do so and repeat until the above command succeeds
```bash
sudo shutdown -r now
```


<div align="center">
  <table style="border-collapse: collapse; width: 100%; border: none;">
    <tr>
     <td align="center" style="border: none;">
        <a href="https://nixos.org/">
          <img src="https://flathub.org/img/distro/nixos.svg" alt="NixOS" style="width: 250%;">
          <br>NixOS
          <td align="center">
          <img src="https://github.com/tolgaerok/Linux-Tweaks-And-Scripts/assets/110285959/af6b682f-0ddd-45bc-babc-0584b0e70884" alt="Screenshot">
        </td>
        </a>
      </td>     
    </tr>
  </table>
</div>

![desktop](https://github.com/tolgaerok/nixos-kde/assets/110285959/c36fc2d7-0885-461b-b2ed-2333e2634a36)
<table style="border-collapse: collapse; width: 100%;">
  <tr>
    <td style="border: none; width: 30%;" valign="top">
      <div align="center">  
          <img src="https://github.com/tolgaerok/nixos/assets/110285959/fa785dec-f839-43f2-9e03-58adb73d12c3" alt="HP" style="width: 80%;">
          <br>          
        </a>
      </div>
    </td>
    <td style="border: none; width: 70%;">
      <table>
        <tr>
          <th align="left">Device</th>
          <th align="left">Specification</th>
        </tr>
        <tr>
          <td>BLUE-TOOTH</td>
          <td>REALTEK 5G</td>
        </tr>
        <tr>
          <td>CPU</td>
          <td>Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz x 8 (Haswell)</td>
        </tr>
        <tr>
          <td>GPU</td>
          <td>NVIDIA GeForce GT 1030/PCIe/SSE2</td>
        </tr>
        <tr>
          <td>MODEL</td>
          <td>HP EliteDesk 800 G1 SFF</td>
        </tr>
        <tr>
          <td>MOTHERBOARD</td>
          <td>Intel® Q87</td>
        </tr>
        <tr>
          <td>NETWORK</td>
          <td>Intel Corporation Wi-Fi 6 AX210/AX211/AX411 160MHz</td>
        </tr>
        <tr>
          <td>RAM</td>
          <td>28 GB DDR3</td>
        </tr>
        <tr>
          <td>SATA</td>
          <td>SAMSUNG SSD 870 EVO 500GB</td>
        </tr>
      </table>
    </td>
  </tr>
</table>

# system upgrades
* Add this into the configuration file if you have issues with Nvidia
```bash  
system.autoUpgrade.enable = true;
system.autoUpgrade.allowReboot = false;
boot.kernelPackages = pkgs.linuxPackages_6_5; # Use pkgs.linuxPackages_6_5 if nvidia drivers fail, use pkgs.linuxPackages_latest if nvidia drivers work on "latest"!
system.autoUpgrade.channel = "https://channels.nixos.org/nixos-23.11";
```

### 1. Clone
```bash
# Tolga Erok
# 14/7/2023
# Post Nixos setup!
# ¯\_(ツ)_/¯

cd $HOME
nix-env -iA nixos.git
git clone https://github.com/tolgaerok/nixos-kde.git
cd nixos-kde
sudo cp /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak
sudo rsync -av --exclude='.git' ./* /etc/nixos
sudo chown -R $(whoami):$(id -gn) /etc/nixos
sudo chmod -R 777 /etc/nixos
sudo chmod +x /etc/nixos/*
export NIXPKGS_ALLOW_INSECURE=1
```

### 2. Create symlink for this host or the machine you prefer
```bash
sudo ln -s nixos /etc/nixos
ln -s nixos/machines/HP-i7-EliteDesk-800-G1-SFF/EliteDesk-800-G1-configuration.nix
sudo nixos-rebuild switch --upgrade
```

```bash
There’s no need to symlink - /etc/nixos/configuration.nix 
is just the default location, and you can change it. 
When you run nixos-rebuild, it looks up the value of “nixos-config” in the
NIX_PATH environment variable, so you can point that wherever you want. 
Example (as root):

export NIX_PATH="nixos-config=/path/to/configuration.nix"
nixos-rebuild switch
```

### nixpkgs
home-manager
```bash
# Clone repo into source dir
mkdir -p ~/s
cd ~/s
git clone https://github.com/tolgaerok/nixos-kde.git
mkdir -p ~/.config
ln -s ~/s/nixos-kde/home-manager ~/.config/home-manager

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

nix-shell '<home-manager>' -A install
```

#

# Table of Contents

**Custom configuration**
:------------------- |
*[[ ✔ ]  Kernel Optimization](#kernel-optimization)* |
*[[ ✔ ]  Custom nixos configuration](#Custom-nixos-configuration)* |
     
**Enabled / Disabled services**
:------------------- |
*[[ ✔ ]  Hardware](#hardware)* |
*[[ ✔ ]  Programs](#programs)* |
*[[ ✔ ]  Services](#services)* |
*[[ ✔ ]  System](#System)* |
*[[ ✔ ]  Virtualisation](#Virtualisation)* |
  
**How to section:**
:------------------- |
*[[ ✔ ]  Clone NixOS & edit (custom) configuration.nix](#Clone-NixOS)* |
  
**Configuring GPU Drivers in my NixOS**
:------------------- |
*[[ ✔ ]  Configuring GPU ](#GPU)* |

**Enhancing User Profile Permissions**
:------------------- |
*[[ ✔ ]  Configuring Profile Permissions](#tweak-profile)* |

**Enhancing System settings** 
:------------------- |
*[[ ✔ ]  Configuring core System settings](#system-enchance)* |

**Final step**
:------------------- |
*[[ ✔ ]  Execute nixos-rebuild switch](#rebuild)* |

    

# *`Pre-production release !!`*



Greetings fellow **NixOS** users! If you're a proud owner of a system equipped desktop with a Nvidia or a laptop with Intel GPU drivers, and your heart beats for the sleekness of KDE Plasma, then this custom configuration has been meticulously crafted with you in mind. My ongoing commitment to updates and fixes ensures that your experience remains top-notch.

It's important to note that, for the time being, I've chosen to disable Wayland in favor of prioritizing Plasma 5 and X11 integration. This emphasis guarantees a seamless and stable experience within the KDE Plasma ecosystem.

Now, let's dive into the exciting lineup I have prepared for you. With just a single command – `sudo nixos-rebuild switch` – you'll unlock a treasure trove of meticulously chosen packages that will transform your NixOS journey.

What exactly does this collection encompass, you ask? Well, it's a finely curated selection of essential software, spanning a diverse array of categories. I've got you covered with:
```javascript
- Archive utilities to effortlessly handle compression and decompression tasks.
- Multimedia tools that pave the way for a vibrant and immersive audio-visual experience.
- Programming languages to fuel your coding endeavors and innovation.
- Office suites that facilitate productivity, organization, and creativity.
- System utilities that provide essential maintenance and management capabilities.
```  
You'll find my selection of handpicked packages available right [here](https://github.com/tolgaerok/nixos/blob/main/packages/ReadMe.md). All of them will be conveniently installed on your NixOS.

These handpicked packages aren't just a random assortment; they're designed to amplify your NixOS adventure, making your system feel complete and your activities seamless. Whether you're crafting code, crafting content, or simply navigating daily tasks, this selection equips you with a versatile toolkit ready for immediate utilization.

So, why the wait? Execute the command, and watch as these packages weave their magic into your NixOS environment. My dedication to providing you with an enriched and functional experience shines through each and every package choice.

Embrace this pre-production release as a sneak peek into the exciting journey ahead. I'm thrilled to have you on board as we explore the NixOS realm together, enhancing and refining the KDE Plasma experience with every step.

Stay tuned for ongoing updates, improvements, and further customization that will ensure your NixOS setup remains at the forefront of innovation and performance. Your adventure with NixOS and KDE Plasma starts here – with a configuration built from an enthusiast, for enthusiasts.




<a name="kernel-optimization"></a>

## *`Enhancing User Experience through Kernel Optimization`*
In the pursuit of an even smoother computing journey, I've delved into the realm of kernel optimization. By fine-tuning how data flows from memory to disk, we can wield significant influence over the performance and responsiveness of our systems. These adjustments aren't just about technical tweaks; they're about crafting an environment that elevates our user experience.

Imagine having the ability to optimize memory usage, fine-tune disk writeback behavior, and even tailor network settings. These kernel tweaks transcend the mundane, offering a deeper level of control over the low-level aspects of our system's behavior. Through this journey of exploration and customization, we're not just configuring a machine; we're sculpting an environment that responds to our needs and aspirations.

```nix
{
  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;                       # SysRQ for is rebooting their machine properly if it freezes: SOURCE: https://oglo.dev/tutorials/sysrq/index.html
    "net.core.rmem_default" = 16777216;       # Default socket receive buffer size, improve network performance & applications that use sockets
    "net.core.rmem_max" = 16777216;           # Maximum socket receive buffer size, determin the amount of data that can be buffered in memory for network operations
    "net.core.wmem_default" = 16777216;       # Default socket send buffer size, improve network performance & applications that use sockets
    "net.core.wmem_max" = 16777216;           # Maximum socket send buffer size, determin the amount of data that can be buffered in memory for network operations
    "net.ipv4.tcp_keepalive_intvl" = 30;      # TCP keepalive interval between probes, TCP keepalive probes, which are used to detect if a connection is still alive.
    "net.ipv4.tcp_keepalive_probes" = 5;      # TCP keepalive probes, TCP keepalive probes, which are used to detect if a connection is still alive.
    "net.ipv4.tcp_keepalive_time" = 300;      # TCP keepalive interval (seconds), TCP keepalive probes, which are used to detect if a connection is still alive.
    "vm.dirty_background_bytes" = 268435456;  # 256 MB in bytes, data that has been modified in memory and needs to be written to disk
    "vm.dirty_bytes" = 1073741824;            # 1 GB in bytes, data that has been modified in memory and needs to be written to disk
    "vm.min_free_kbytes" = 65536;             # Minimum free memory for safety (in KB), can help prevent memory exhaustion situations
    "vm.swappiness" = 1;                      # how aggressively the kernel swaps data from RAM to disk. Lower values prioritize keeping data in RAM,
    "vm.vfs_cache_pressure" = 50;             # Adjust vfs_cache_pressure (0-1000), how the kernel reclaims memory used for caching filesystem objects
  };
```

Detailed information ─>> [here](https://raw.githubusercontent.com/tolgaerok/nixos/main/system/kernel-sysctl/default.nix).


[Back to Top](#)

## Syncing User Home Folder to a Specified Destination

One of the key scripts I've developed is a custom synchronization script. This script allows me to effortlessly sync my user home folder to a specified destination. By running this script, I can ensure that all my important files and configurations are backed up and accessible from any location. This is particularly helpful when I switch machines or need to restore my settings after a fresh installation.

## Assisting with Mounting, Unmounting, and Suspending

To streamline my workflow, I've also developed a set of personal scripts that assist me with mounting, unmounting, and suspending operations. These scripts automate common tasks, saving me time and effort in managing external drives or suspending my system when I step away. By executing these scripts, I can perform these operations with just a single command, making my workflow more efficient.


## Calling Common NixOS Commands with a Custom Script

To further simplify my interactions with NixOS, I've developed a custom script that encapsulates the most frequently used commands. With this script, I can quickly execute common tasks such as updating the system, installing packages, or configuring services. This saves me the hassle of remembering or typing out lengthy commands each time I need to perform these operations.

![1](https://github.com/tolgaerok/Linux-Tweaks-And-Scripts/assets/110285959/ae14cea8-dae9-4ea9-842d-7232e62ca9ff)

<a name="Custom-nixos-configuration"></a>
# **Custom nixos configuration:**

<a name="hardware"></a>
### Hardware

Hardware | Enable | Description
:------------ | :---------- | :----------
`driSupport` | `true` | Enable accelerated OpenGL rendering through the Direct Rendering Interface (DRI).
`driSupport32Bit` | `true` | On 64-bit systems, whether to support Direct Rendering for 32-bit applications.
`plymouth` | `false` | Enable Plymouth boot splash screen.
`sane` | `false` | Enable support for SANE scanners.
`brscan4` | `false` | Automatically register the "brscan4" sane backend and bring configuration files to their expected location.

[Back to Top](#)

<a name="programs"></a>
### Programs

Programs | Enable | Description
:------------ | :---------- | :----------
`adb` | `true` | Whether to configure system to use Android Debug Bridge (adb).
`command-not-found` | `true` | Whether interactive shells should show which Nix package (if any) provides a missing command.
`dconf` | `true` | Enable dconf.
`firefox` | `true` | Enable the Firefox web browser.
`fish` | `true` | Whether to configure fish as an interactive shell.
`git` | `true` | Enable git.
`gnupg.agent` | `true` | Enables GnuPG agent with socket-activation for every user session.
`java` | `true` | Install and setup the Java development kit.
`kdeconnect` | `true` | Enable kdeconnect.
`mtr` | `true` | Whether to add mtr to the global environment and configure a setcap wrapper for it.
`partition-manager` | `true` | Enable KDE Partition Manager.
`corectrl` | `false` | Enable A tool to overclock amd graphics cards and processors.
`htop` | `false` | Enable htop process monitor.
`steam` | `false` | Enable steam.

[Back to Top](#)

<a name="services"></a>
### Services

Service | Enable | Description
:------------ | :---------- | :----------
`fstrim` | `true` | Enable periodic SSD TRIM of mounted partitions in background.
`mysql` | `true` | Enable MySQL server (MariaDB).
`pipewire` | `true` | Enable pipewire service.
`postgresql` | `true` | Enable PostgreSQL Server.
`power-profiles-daemon` | `false` | DBus daemon that allows changing system behavior based upon user-selected power profiles.
`printing` | `true` | Enable printing support through the CUPS daemon.
`redis` | `true` | An open source, advanced key-value store.
`sddm` | `true` | Enable sddm as the display manager.
`udev` | `true` | Enable udev.
`udisks2` | `true` | DBus service that allows applications to query and manipulate storage devices.
`xserver` | `true` | Enable the X server.
`avahi` | `false` | Allows Avahi clients to use Avahi's service discovery facilities.
`mongodb` | `false` | Enable MongoDB Server.
`metabase` | `false` | Enable Metabase service.
`openssh` | `false` | OpenSSH secure shell daemon, which allows secure remote logins.
`thermald` | `false` | Enable thermald, the temperature management daemon.
`tlp` | `false` | Enable the TLP power management daemon.

[Back to Top](#)

<a name="System"></a>
### System

System | Enable | Description
:------------ | :---------- | :----------
`allowUnfree` | `true` | The configuration of the Nix Packages collection to allow unfree packages.
`auto-optimise-store` | `true` | Replaces files in the store that have identical contents with hard links to a single copy.
`bluetooth` | `true` | Enable support for Bluetooth.
`doas` | `true` | Enable the doas command, which allows non-root users to execute commands as root.
`firewall` | `false` | This is a simple stateful firewall that blocks connection attempts to unauthorised TCP or UDP ports on this machine.
`networkmanager` | `true` | Obtain an IP address and other configuration for all network interfaces that are not manually configured.
`nix.gc.automatic` | `true` | Automatically run the garbage collector at a specific time.
`nix.optimise` | `true` | Automatically run the nix store optimiser at a specific time.
`powerManagement` | `false` | Enable power management. This includes support for suspend-to-RAM and powersave features on laptops.
`rtkit` | `true` | Enable the RealtimeKit system service, which hands out realtime scheduling priority to user processes on demand.
`useTmpfs` | `true` | Whether to mount a tmpfs on /tmp during boot.
`zramSwap` | `true` | Enable in-memory compressed devices and swap space provided by the zram kernel module.
`allowReboot` | `false` | Reboot the system into the new generation instead of a switch.
`autoUpgrade` | `false` | Whether to periodically upgrade NixOS to the latest version.
`documentation.doc` | `false` | Whether to install documentation distributed in packages' /share/doc.
`documentation.info` | `false` | Whether to install info pages and the info command. This also includes "info" outputs.
`documentation.nixos` | `false` | Whether to install NixOS's own documentation.
`iwd` | `false` | Enable iwd.
`oomd` | `false` | Whether to disable the systemd-oomd OOM killer.
`pulseaudio` | `false` | Enable the PulseAudio sound server.
`useOSProber` | `true` | If set to true, append entries for other OSs detected by os-prober.
`xdg.portal.lxqt` | `false` | Enable the desktop portal for the LXQt desktop environment.
`xdg.portal.wlr` | `false` | Enable desktop portal for wlroots-based desktops.

[Back to Top](#)

<a name="Virtualisation"></a>
### Virtualisation

Virtualisation | Enable | Description
:------------ | :---------- | :----------
`docker` | `false` | This option enables docker, a daemon that manages linux containers.

[Back to Top](#)

<a name="Clone-NixOs"></a>

# *`How to section`*
#
# Clone NixOS Configuration Repository and Apply Permissions

*Open Dolphin and go to your:*
```
  - home directory
  - press F4 
```
*Advanced users:*
If your confident with the use of the termnal, you can simply copy and paste the following and hit return. Or if you want to learn
and get a feel for some manaul steps, skip this and go to *Step 1*:

```bash
# Tolga Erok
# 14/7/2023
# Post Nixos setup!
# ¯\_(ツ)_/¯

cd $HOME
nix-env -iA nixos.git
git clone https://github.com/tolgaerok/nixos.git
cd nixos
sudo rsync -av --exclude='.git' ./* /etc/nixos
sudo chown -R $(whoami):$(id -gn) /etc/nixos
sudo chmod -R 777 /etc/nixos
sudo cp /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak
kate /etc/nixos/configuration.nix
export NIXPKGS_ALLOW_INSECURE=1
```
## Step 1: 
*Install basic git, download my NixOS.zip repository, unzip, open nixos-main folder*

Step 1: Install git
```nix
nix-env -iA nixos.git
```
Step 2: Clone my repository  
```bash
git clone https://github.com/tolgaerok/nixos.git
```
Step 3: Unzip the downloaded file
```bash
  cd nixos
```
## Step 2: 
*Copy the contents of the cloned "nixos" folder to /etc/nixos*
*Note: This will exclude the hidden .git folder*
```bash
sudo rsync -av --exclude='.git' ./* /etc/nixos
```
## Step 3: 
*Set appropriate ownership and permissions*

Step 1:
```bash
sudo chown -R $(whoami):$(id -gn) /etc/nixos
```
Step 2:
```bash
sudo chmod -R 777 /etc/nixos
```
## Backup your original configuration.nix file
```bash
sudo cp /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak
```
## Step 4: 
**If you're using the command line or terminal, you can open the `configuration.nix` file using a text editor called `nano`. Here's how:**

  - **Open a terminal on your NixOS system.**

  - **To open the `configuration.nix` file using the `nano` text editor, type the following command:**

   ```bash
   nano /etc/nixos/configuration.nix
   ```

  - **This will open the `configuration.nix` file in the `nano` editor, allowing you to make changes. Navigate to the appropriate location and add or modify the lines as needed.**

  - **After making your changes, press `Ctrl` + `O` to save the changes, then press `Enter`. To exit `nano`, press `Ctrl` + `X`.**

If you prefer to use the graphical text editor `Kate`, you can follow these steps:

  - **Open a terminal on your NixOS system.**

  - **To open the `configuration.nix` file using `Kate`, type the following command:**

   ```bash
   kate /etc/nixos/configuration.nix
   ```

  - **This will open the `configuration.nix` file in the `Kate` editor. You can navigate to the desired location and make changes directly in the graphical interface.**
    
### Locate the imports section in the file. It will look like this: ###

*This is the default layout on new install*
 ```nix
  imports =
  [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
```
### Add the desired lines just before the closing square bracket ]. Make sure to maintain the indentation. Here's how it should look after adding the lines: ###
```nix
imports = [ 
   # ./hardware/gpu/intel/intel-laptop                     # INTEL GPU with (Open-GL), tlp and auto-cpufreq
   # ./hardware/gpu/nvidia/nvidia-stable/nvidia-stable.nix  # NVIDIA stable for GT-710--
   # ./hardware/gpu/nvidia/nvidia-opengl/nvidia-opengl.nix  # NVIDIA with hardware acceleration (Open-GL) for GT-1030++
    ./hardware-configuration.nix
    ./nix
    ./packages
    ./programs
    ./services
    ./system
  ];

# Including this
nixpkgs.config.permittedInsecurePackages = [ "openssl-1.1.1v" ];

```

  - **After making your changes, save the file using the appropriate option in the `Kate` menu.**

Keep in mind that `nano` is a terminal-based text editor, while `Kate` is a graphical text editor. You can choose the one that you're more comfortable with. Additionally, when using graphical editors like `Kate`, be sure to launch them with `sudo` to have the necessary permissions to edit system files.

[Back to Top](#)

#
<a name="GPU"></a>
# Configuring GPU Drivers in NixOS

If you're looking to configure GPU drivers on your NixOS system, follow these steps to choose the appropriate driver based on your hardware:

1. **Open `configuration.nix` File:**

   Open a terminal and navigate to your NixOS configuration directory. Use either of the following methods to open the `configuration.nix` file:

   - **Using nano:**
     ```bash
     sudo nano /etc/nixos/configuration.nix
     ```
   - **Using Kate Text Editor:**
     ```bash
     kate /etc/nixos/configuration.nix
     ```

2. **Locate GPU Driver Options:**

   After successfully adding the required lines from **Step 4**, in the `configuration.nix` file, scroll down until you find the `imports = [` section. This section is usually located near the beginning of the file and should looks like this now:
   
```nix
imports = [ 
   # ./hardware/gpu/intel/intel-laptop                      # INTEL GPU with (Open-GL), tlp and auto-cpufreq
   # ./hardware/gpu/nvidia/nvidia-stable/nvidia-stable.nix  # NVIDIA stable for GT-710--
   # ./hardware/gpu/nvidia/nvidia-opengl/nvidia-opengl.nix  # NVIDIA with hardware acceleration (Open-GL) for GT-1030++
    ./hardware-configuration.nix
    ./nix
    ./packages
    ./programs
    ./services
    ./system
  ];

# Including this
nixpkgs.config.permittedInsecurePackages = [ "openssl-1.1.1v" ];
```

   The top few lines in the `imports = [ ... ]` line, you will find the GPU driver options section. It will look like this:
   
   ```nix
   # ./hardware/gpu/intel/intel-laptop                      # INTEL GPU with (Open-GL), tlp and auto-cpufreq
   # ./hardware/gpu/nvidia/nvidia-stable/nvidia-stable.nix  # NVIDIA stable for GT-710--
   # ./hardware/gpu/nvidia/nvidia-opengl/nvidia-opengl.nix  # NVIDIA with hardware acceleration (Open-GL) for GT-1030++
   ```

3. **Choose Your GPU Driver:**

   Depending on your hardware, you can choose the appropriate GPU driver option. Each option is followed by a brief description of its use case. Comment out (add `#` at the beginning of the line) the lines for GPU drivers you don't need. For   example, if you have an Intel GPU, comment out the lines related to NVIDIA drivers.
   
    *For example, if you have an Intel GPU and want to use the Intel driver, it should look like:*
```nix
   imports = [ 
   ./hardware/gpu/intel/intel-laptop                      # INTEL GPU with (Open-GL), tlp and auto-cpufreq
   # ./hardware/gpu/nvidia/nvidia-stable/nvidia-stable.nix  # NVIDIA stable for GT-710--
   # ./hardware/gpu/nvidia/nvidia-opengl/nvidia-opengl.nix  # NVIDIA with hardware acceleration (Open-GL) for GT-1030++
    ./hardware-configuration.nix
    ./nix
    ./packages
    ./programs
    ./services
    ./system
  ];

# Including this
nixpkgs.config.permittedInsecurePackages = [ "openssl-1.1.1v" ];
```

5. **Save and Apply Changes:**

   After making your choice, save the changes to the `configuration.nix` file. If you used *nano*, press `Ctrl + O` to write the changes and then `Ctrl + X` to exit. If you used *Kate*, simply close the editor.
   
By following these steps, you can easily configure GPU drivers on your NixOS system according to your hardware setup. Remember to regularly check for updates and changes in the driver options based on your hardware requirements.

[Back to Top](#)

#
<a name="tweak-profile"></a>
# Elevating Your NixOS Experience: Enhancing User Profile Permissions

Welcome to the realm of NixOS customization! As you navigate the intricacies of your NixOS system, you might find the need to empower your user profile with enhanced permissions, allowing you to seamlessly interact with various components of the platform. By following these steps, you'll empower your user-profile with an enriched profile that includes extended permissions and group memberships. 

*Here's how you can achieve just that:*

1. **Open `configuration.nix` File:**

   Open a terminal and navigate to your NixOS configuration directory. Use either of the following methods to open the `configuration.nix` file:

   - **Using nano:**
     ```bash
     sudo nano /etc/nixos/configuration.nix
     ```
   - **Using Kate Text Editor:**
     ```bash
     kate /etc/nixos/configuration.nix
     ```

2. **Locate Your User Profile Section**

Within the `configuration.nix` file, you'll discover a section dedicated to your user profile. This portion, often resembling the following structure, encapsulates your user-specific settings:

```nix
users.users.username = {
  isNormalUser = true;
  description = "User's Full Name";
  extraGroups = [ "wheel" "networkmanager" ];
};
```

3. **Enhance Your Profile's Capabilities**

It's here that the magic unfolds. After the `description` line in your user profile section, you'll introduce a set of configurations designed to amplify your permissions and enrich your interactions within NixOS. 
Simply copy & paste where the indicators are:

```nix
users.users.username = {
  isNormalUser = true;
  description = "User's Full Name";

  homeMode = "0755";        # <-----  Copy from here
  uid = 1000;  # Replace with your specific UID
  extraGroups = [
    "adbusers"
    "audio"
    "corectrl"
    "disk"
    "input"
    "lp"
    "mongodb"
    "mysql"
    "network"
    "networkmanager"
    "postgres"
    "power"
    "scanner"
    "sound"
    "systemd-journal"
    "users"
    "video"
    "wheel"      
  ];
  packages = [ pkgs.home-manager ];   # <-----  To here

};

```

These lines of code not only bestow you with enhanced permissions, but they also extend your access to specific groups that define various aspects of NixOS functionality. With the inclusion of `pkgs.home-manager`, your configuration takes a step towards seamless management of your user settings.

[Back to Top](#)

<a name="system-enchance"></a> 
#
**System Enhancements**

To effortlessly amplify your NixOS system, consider integrating this snippet below the audio configuration. It’s a quick process that will bring a host of automatic upgrades and system enhancements into play:

*Note: Do not over write or leave out `system.stateVersion = "23.05";`*

```nix
# --------------------------------------------------------------------
# Automated System Enhancements
# --------------------------------------------------------------------

# Enable automatic system upgrades and reboots if necessary
system.autoUpgrade.enable = true;
# system.autoUpgrade.allowReboot = true;
system.copySystemConfiguration = true;
systemd.extraConfig = "DefaultTimeoutStopSec=10s";
```

This simple snippet wields great power. It introduces automatic system upgrades and, if required, seamless reboots. By enabling `system.autoUpgrade`, you let your NixOS stay up to date effortlessly. With `system.copySystemConfiguration`, system enhancements become a part of your experience. The `systemd.extraConfig` adds a touch of efficiency to stop sequences.

1. **Swift Copy-Paste**

Integrating the above snippet is as swift as its enhancements. Just copy the snippet beneath your audio configuration in your `configuration.nix` file. 

[Back to Top](#)

#
<a name="rebuild"></a>
# nixos-rebuild switch

After adding all the configurations above, save the `configuration.nix` file. To apply the changes, execute the following command in your terminal:

   ```nix
   export NIXPKGS_ALLOW_INSECURE=1
   sudo nixos-rebuild switch --upgrade
   ```

This command will update your system with the new GPU driver, audio, system and user profile configurations. If this is your first rebuild from this repository, the required files and services will now start to install.

*If this is your first rebuild along with the GPU driver selection, the overall process WILL take some time, so, grab a cuppa and enjoy the ride!*

[Back to Top](#)

#
## Conclusion

In this blog post, I've highlighted some of the key components of my GitHub environment. From syncing my user home folder to developing scripts for mounting, unmounting, and suspending, to customizing my NixOS configuration file with Bluetooth variables and creating a script for common NixOS commands, these tools greatly enhance my productivity and simplify my workflow.

If you're interested in exploring these scripts or incorporating them into your own environment, feel free to check out my GitHub repository. I hope you find them useful and they inspire you to create your own custom solutions to enhance your development experience!

Happy coding! 😄

[Back to Top](#)
#


## *Other repositories in my git hub:*

<div align="center">
  <table style="border-collapse: collapse; width: 100%; border: none;">
    <tr>
     <td align="center" style="border: none;">
        <a href="https://github.com/tolgaerok/fedora-tolga">
          <img src="https://flathub.org/img/distro/fedora.svg" alt="Fedora" style="width: 100%;">
          <br>Fedora
        </a>
      </td>
      <td align="center" style="border: none;">
        <a href="https://github.com/tolgaerok/Debian-tolga">
          <img src="https://flathub.org/img/distro/debian.svg" alt="Debian" style="width: 100%;">
          <br>Debian
        </a>
      </td>
    </tr>
  </table>
</div>

## *My Stats:*

<div align="center">

<div style="text-align: center;">
  <a href="https://git.io/streak-stats" target="_blank">
    <img src="http://github-readme-streak-stats.herokuapp.com?user=tolgaerok&theme=dark&background=000000" alt="GitHub Streak" style="display: block; margin: 0 auto;">
  </a>
  <div style="text-align: center;">
    <a href="https://github.com/anuraghazra/github-readme-stats" target="_blank">
      <img src="https://github-readme-stats.vercel.app/api/top-langs/?username=tolgaerok&layout=compact&theme=vision-friendly-dark" alt="Top Languages" style="display: block; margin: 0 auto;">
    </a>
  </div>
</div>
</div>
</div>
</div>

Back to [Index](#index)
