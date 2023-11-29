{ lib, pkgs, ... }:

let
  email = "kingtolga@gmail.com";
  fullname = "Tolga Erok";

in {
  imports = [
    #./gitfs.nix

  ];

  # Add the necessary packages
  environment.systemPackages = with pkgs; [
    gcc
    gitfs
    python39Packages.virtualenv # or use python3Packages.virtualenv if it corresponds to Python 3.9
  ];

  programs = {
    git = {
      enable = true;
      package =
        pkgs.gitAndTools.gitFull; # Install git wiith all the optional extras

      lfs = {
        # Git Large File Storage (LFS)
        enable = true;
      };

      extraConfig = {
        commit = {
          # Remove the gpgsign line or set it to "false" to disable GPG signing...
          # gpgsign = "false";

          # Add this line to enable signing commits with your SSH key
          # You may also need to configure Git to use your SSH key globally
          # (outside of this NixOS configuration).
          # See the note below for instructions.
          # signingKey = "ssh-ed25519";
        };

        #init = { defaultBranch = "main"; };
        #pull = { rebase = "true"; };

        # Cache git credentials for 15 minutes
        credential.helper = "cache";

        core.editor = "kate";
        github.user = "tolgaerok";
        init.defaultBranch = "main";
        pull.rebase = true;

        ignores = [
          ".envrc"
          ".direnv"
          "NIXOS-*"

        ];

        url = {
          "git@github.com:" = {
            insteadOf = [
              "https://github.com/"

            ];
          };

          "git@gitlab.com:" = {
            insteadOf = [
              "https://gitlab.com/"

            ];

          };
        };

        user = {
          email = "${email}";
          name = "${fullname}";
        };

        core = {
          # sshCommand = "ssh -i $HOME/.ssh/id_ed25519"; 

        };

        status = {
          short = true;

        };

      };
    };
  };

  # Trouble shoot git
  # git remote remove main && git remote add origin git@github.com:tolgaerok/nixos-kde.git && git pull origin main
  # or
  # git checkout main && git fetch origin
  # git reset --hard origin/main &&  git pull origin main && git push origin main

  # Do in terminal::
  # cat ~/.ssh/id_ed25519.pub
  # git config --global user.signingkey your_ssh_key_id_here

}
