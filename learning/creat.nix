{ lib, ... }:

let homedir = builtins.getEnv "HOME";

in {
  inherit (lib) mkForce;

  homeFolders = lib.mkForce {
    inherit homedir;

    userA = mkForce {
      target = "${homedir}/A";
      action = "mkdir -p $target";
    };

    userB = mkForce {
      target = "${homedir}/B";
      action = "mkdir -p $target";
    };

    userC = mkForce {
      target = "${homedir}/C";
      action = "mkdir -p $target";
    };

  };
}
