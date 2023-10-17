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
    gnome.gnome-boxes

  ];

  #---------------------------------------------------------------------
  # Manage the virtualisation services
  #---------------------------------------------------------------------
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };

    spiceUSBRedirection.enable = true;

  };

  services.spice-vdagentd.enable = true;

}
