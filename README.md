# *`My NixOs 23.05 environment`*
```sh
Tolga Erok
14/6/2023
```
<div align="left">
  <table style="border-collapse: collapse; width: 100%; border: none;">
    <tr>
     <td align="center" style="border: none;">
        <a href="https://nixos.org/">
          <img src="https://flathub.org/img/distro/nixos.svg" alt="NixOS" style="width: 100%;">
          <br>NixOS
        </a>
      </td>     
    </tr>
  </table>
</div> 

<a name="index"></a>
# [Index](#index)

- ***Custom configuration***
  - [Kernel Optimization](#kernel-optimization)
  - [Custom nixos configuration](#Custom-nixos-configuration)
     
- ***Enabled / Disabled services***
  - [Hardware](#hardware)
  - [Programs](#programs)
  - [Services](#services)
  - [System](#System)
  - [Virtualisation](#Virtualisation)
  
- ***How to section***
  - [Clone NixOS & edit (custom) configuration.nix](#Clone-NixOS)
  
- ***Configuring GPU Drivers in my NixOS***
  - [Configuring GPU ](#GPU)

# *`Pre-production release !!`*
I've carefully curated a collection of essential packages that you can effortlessly install on your NixOS system using a single command: `sudo nixos-rebuild switch`. You'll find my selection of handpicked packages available right [here](https://github.com/tolgaerok/nixos/blob/41ad9b1ac3eeedf8de3cdeeb559acf3cb5913186/packages/ReadMe.md). All of them will be conveniently installed on your NixOS.

These carefully selected programs cover a wide range of categories, from:

- **archive utilities**
- **multimedia tools** 
- **programming languages**
- **office suites**
- **system utilities**



By including these packages, I've aimed to enhance your NixOS experience and make your system feel more complete. Whether you're a developer, content creator, or everyday user, these additions offer a well-rounded toolkit that's ready for immediate use. Simply run the command, and enjoy the convenience and functionality that these packages bring to your NixOS environment.

![Screenshot_20230610_144645](https://github.com/tolgaerok/Linux-Tweaks-And-Scripts/assets/110285959/af6b682f-0ddd-45bc-babc-0584b0e70884)


<a name="kernel-optimization"></a>
## *`Enhancing User Experience through Kernel Optimization`*
In the pursuit of an even smoother computing journey, I've delved into the realm of kernel optimization. By fine-tuning how data flows from memory to disk, we can wield significant influence over the performance and responsiveness of our systems. These adjustments aren't just about technical tweaks; they're about crafting an environment that elevates our user experience.

Imagine having the ability to optimize memory usage, fine-tune disk writeback behavior, and even tailor network settings. These kernel tweaks transcend the mundane, offering a deeper level of control over the low-level aspects of our system's behavior. Through this journey of exploration and customization, we're not just configuring a machine; we're sculpting an environment that responds to our needs and aspirations.
```
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
Back to [Index](#index)

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

Back to [Index](#index)

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

Back to [Index](#index)

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

Back to [Index](#index)

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

Back to [Index](#index)

<a name="Virtualisation"></a>
### Virtualisation

Virtualisation | Enable | Description
:------------ | :---------- | :----------
`docker` | `false` | This option enables docker, a daemon that manages linux containers.

Back to [Index](#index)



# *`How to section`*

1. *Open*
- home directory
- press F4 

# 
<a name="Clone-NixOs"></a>
# Clone NixOS Configuration Repository and Apply Permissions

## Step 1: 
*Install basic git, clone my NixOS repository and move into the cloned directory*
```sh
nix-shell -p git
git clone https://github.com/tolgaerok/nixos.git
cd nixos
```

## Step 2: 
*Copy the contents of the cloned "nixos" folder to /etc/nixos*
*Note: This will exclude the hidden .git folder*
```
sudo rsync -av --exclude='.git' ./* /etc/nixos
```
## Step 3: 
*Set appropriate ownership and permissions*
```
sudo chown -R $(whoami):$(id -gn) /etc/nixos
sudo chmod -R 750 /etc/nixos
```
## Backup your original configuration.nix file
```
sudo cp /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak
```
## Step 4: 
*Copy the following command and paste it into your terminal to automate the edit process into the `configuration.nix` file using the awk command:*
```
import_line_number=$(grep -n 'imports = \[' /etc/nixos/configuration.nix | cut -d ':' -f 1)

new_lines=(
  "  # ./hardware/gpu/intel/intel-laptop/                     # INTEL GPU with (Open-GL), tlp and auto-cpufreq"
  "  # ./hardware/gpu/nvidia/nvidia-stable/nvidia-stable.nix  # NVIDIA stable for GT-710--"
  "  # ./hardware/gpu/nvidia/nvidia-opengl/nvidia-opengl.nix  # NVIDIA with hardware acceleration (Open-GL) for GT-1030++"
  "  ./hardware-configuration.nix"
  "  ./nix"
  "  ./packages"
  "  ./programs"
  "  ./services"
  "  ./system"
)

awk -v lines="$(printf "%s\n" "${new_lines[@]}")" -v line_num="$import_line_number" \
  'NR == line_num + 1 { printf lines "\n"; } { print; }' /etc/nixos/configuration.nix > temp_config.nix

mv temp_config.nix /etc/nixos/configuration.nix
```
*This command will insert the new lines just after the line containing imports = [ in the configuration.nix file.*

After running the command, your `configuration.nix` file will be updated. You can check the changes using a text editor or a terminal-based text viewer.

If you're using the command line or terminal, you can open the `configuration.nix` file using a text editor called `nano`. Here's how:

  - **Open a terminal on your NixOS system.**

  - **To open the `configuration.nix` file using the `nano` text editor, type the following command:**

   ```
   nano /etc/nixos/configuration.nix
   ```

  - **This will open the `configuration.nix` file in the `nano` editor, allowing you to make changes. Navigate to the appropriate location and add or modify the lines as needed.**

  - **After making your changes, press `Ctrl` + `O` to save the changes, then press `Enter`. To exit `nano`, press `Ctrl` + `X`.**

If you prefer to use the graphical text editor `Kate`, you can follow these steps:

  - **Open a terminal on your NixOS system.**

  - **To open the `configuration.nix` file using `Kate`, type the following command:**

   ```
   kate /etc/nixos/configuration.nix
   ```

  - **This will open the `configuration.nix` file in the `Kate` editor. You can navigate to the desired location and make changes directly in the graphical interface.**

  - **After making your changes, save the file using the appropriate option in the `Kate` menu.**

Keep in mind that `nano` is a terminal-based text editor, while `Kate` is a graphical text editor. You can choose the one that you're more comfortable with. Additionally, when using graphical editors like `Kate`, be sure to launch them with `sudo` to have the necessary permissions to edit system files.

Back to [Index](#index)

#
<a name="GPU"></a>
# Configuring GPU Drivers in NixOS

If you're looking to configure GPU drivers on your NixOS system, follow these steps to choose the appropriate driver based on your hardware:

1. **Open `configuration.nix` File:**

   Open a terminal and navigate to your NixOS configuration directory. Use either of the following methods to open the `configuration.nix` file:

   - **Using nano:**
     ```
     sudo nano /etc/nixos/configuration.nix
     ```
   - **Using Kate Text Editor:**
     ```
     kate /etc/nixos/configuration.nix
     ```

2. **Locate GPU Driver Options:**

   In the `configuration.nix` file, scroll down until you find the `imports = [` section. This section is usually located near the beginning of the file and looks like:
   
   ```nix
   imports = [
     ./hardware-configuration.nix
     # Other imports...
   ];
   ```

   Beneath the `imports = [ ... ]` line, you will find the GPU driver options section. It will look like this:
   
   ```nix
   # ./hardware/gpu/intel/intel-laptop/                     # INTEL GPU with (Open-GL), tlp and auto-cpufreq
   # ./hardware/gpu/nvidia/nvidia-stable/nvidia-stable.nix  # NVIDIA stable for GT-710--
   # ./hardware/gpu/nvidia/nvidia-opengl/nvidia-opengl.nix  # NVIDIA with hardware acceleration (Open-GL) for GT-1030++
   ```

3. **Choose Your GPU Driver:**

   Depending on your hardware, you can choose the appropriate GPU driver option. Each option is followed by a brief description of its use case. Comment out (add `#` at the beginning of the line) the lines for GPU drivers you don't need. For   example, if you have an Intel GPU, comment out the lines related to NVIDIA drivers.
   
    *For example, if you have an Intel GPU and want to use the Intel driver, it should look like:*
   
    ```
    ./hardware/gpu/intel/intel-laptop/                     # INTEL GPU with (Open-GL), tlp and auto-cpufreq
    # ./hardware/gpu/nvidia/nvidia-stable/nvidia-stable.nix  # NVIDIA stable for GT-710--
    # ./hardware/gpu/nvidia/nvidia-opengl/nvidia-opengl.nix  # NVIDIA with hardware acceleration (Open-GL) for GT-1030++
    ```

5. **Save and Apply Changes:**

   After making your choice, save the changes to the `configuration.nix` file. If you used *nano*, press `Ctrl + O` to write the changes and then `Ctrl + X` to exit. If you used *Kate*, simply close the editor.

6. **Update Configuration:**

   Apply the changes by rebuilding the NixOS configuration:
   
   ```
   sudo nixos-rebuild switch
   ```

   This command will update your system with the new GPU driver configuration.

By following these steps, you can easily configure GPU drivers on your NixOS system according to your hardware setup. Remember to regularly check for updates and changes in the driver options based on your hardware requirements.

#
## Conclusion

In this blog post, I've highlighted some of the key components of my GitHub environment. From syncing my user home folder to developing scripts for mounting, unmounting, and suspending, to customizing my NixOS configuration file with Bluetooth variables and creating a script for common NixOS commands, these tools greatly enhance my productivity and simplify my workflow.

If you're interested in exploring these scripts or incorporating them into your own environment, feel free to check out my GitHub repository. I hope you find them useful and they inspire you to create your own custom solutions to enhance your development experience!

Happy coding! 😄

Back to [Index](#index)
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
