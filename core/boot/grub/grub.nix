{ config, lib, ... }:

{
  # Bootloader for BIOS bootup
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  #  boot.loader.grub.kernelParams = [ "video.allow_duplicates = 1" ];

  # Copies latest Linux kernels for smoother boot.
  boot.loader.grub.copyKernels = true; 

  # silence ACPI "errors" at boot shown before NixOS stage 1 output (default is 4)
  boot.consoleLogLevel = 3;

  # tmpfs (a filesystem stored in RAM) settings for the NixOS boot process.
  # Clean tmpfs on system boot, useful for ensuring a clean state.
  boot.tmp.cleanOnBoot = true;  

  # Enable tmpfs for the specified directories.
  boot.tmp.useTmpfs = true;

  # Allocate 25% of RAM for tmpfs. You can adjust this percentage to your needs.
  boot.tmp.tmpfsSize = "35%";

  # Control and optimize how an application utilizes the processor resources based on G1 800 ==> 8 × Intel® Core™ i7-4770 CPU @ 3.40GHz
  boot.extraModprobeConfig = ''
    options nptl Thread.ProcessorCount=8 Thread.MaxProcessorCount=8 Thread.MinFreeProcessorCount=1 Thread.JobThreadPriority=0  
  '';

  # Nobara Tweaks
  boot.kernel.sysctl = {
    "fs.aio-max-nr" = 1048576;                                 # defines the maximum number of asynchronous I/O requests that can be in progress at a given time.
    "fs.inotify.max_user_watches" = 524288;                    # sets the maximum number of file system watches, enhancing file system monitoring capabilities.
    "kernel.panic" = 5;                                        # Reboot after 5 seconds on kernel panic
    "kernel.pid_max" = 4194304;                                # allows a large number of processes and threads to be managed
    
    # "kernel.sched_min_granularity_ns" = "10000000";
    # "kernel.sched_wakeup_granularity_ns" = "15000000";
  };

}

