{ config, lib, pkgs, ... }:

{
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = true;

  # Nvidia Docker
  virtualisation.docker.enableNvidia = true;
  # libnvidia-container does not support cgroups v2 (prior to 1.8.0)
  # https://github.com/NVIDIA/nvidia-docker/issues/1447
  systemd.enableUnifiedCgroupHierarchy = false;
}
