{ config, pkgs, ... }:


# ---------------------------------------------------------------------
# Virt manager (BETA)
# ---------------------------------------------------------------------

# Go to the menu then click connect to server or something like that. 
# Then just leave everything default and click connect and it should work.

{

  # Enable dconf (System Management Tool)
  programs.dconf.enable = true;

  # Add user to libvirtd group
  # users.users.tolga.extraGroups = [ "libvirtd" ];

  # Install necessary packages
  environment.systemPackages = with pkgs; [
    OVMFFull
    gnome.adwaita-icon-theme
    kvmtool
    libvirt
    qemu
    spice
    spice
    spice
    spice-gtk
    spice-protocol
    spice-vdagent
    swtpm
    virt-manager
    virt-manager
    virt-viewer
    win-spice
    win-virtio
  ];

  # Manage the virtualisation services
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

}
