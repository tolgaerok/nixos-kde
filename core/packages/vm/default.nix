{ config, pkgs, ... }:

{

  #---------------------------------------------------------------------
  # Install necessary packages
  #---------------------------------------------------------------------
  environment.systemPackages = with pkgs; [

    OVMFFull
    gnome.adwaita-icon-theme
    kvmtool
    libvirt
    qemu
    spice
    spice-gtk
    spice-protocol
    spice-vdagent
    swtpm
    virt-manager
    virt-viewer
    win-spice
    win-virtio
    virtualbox
    # gnome.gnome-boxes

  ];

  #---------------------------------------------------------------------
  # Manage the virtualisation services : Libvirt stuff
  #---------------------------------------------------------------------
  virtualisation = {
    libvirtd = {
      enable = true;
      onBoot = "ignore";

      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };

    spiceUSBRedirection.enable = true;

  };

  services.spice-vdagentd.enable = true;
  systemd.services.libvirtd.restartIfChanged = false;

  # vmVariant configuration is added only when building VM with nixos-rebuild
  
  # build-vm
  virtualisation.vmVariant = {
    virtualisation = {
      cores = 7;
      memorySize = 8192; # Use 8GB memory (value is in MB)
    };
  };

}
