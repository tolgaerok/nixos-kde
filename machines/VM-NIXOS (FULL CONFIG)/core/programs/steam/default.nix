{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [ steam vulkan-headers ntfs3g ];
  programs = { steam = { enable = false; }; };
}
