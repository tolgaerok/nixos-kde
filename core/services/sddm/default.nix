{ config, lib, pkgs, qtbase, qtsvg, qtgraphicaleffects, qtquickcontrols2
, wrapQtAppsHook, stdenvNoCC, fetchFromGitHub, themeIni, ... }:

# ------------------------------------------
# SDDM custom themes
# ------------------------------------------

let
  buildTheme = { name, version, src, themeIni ? [ ] }:
    pkgs.stdenv.mkDerivation rec {
      pname = "sddm-theme-${name}";
      inherit version src;

      buildCommand = ''
        dir=$out/share/sddm/themes/${name}
        doc=$out/share/doc/${pname}

        mkdir -p $dir $doc
        if [ -d $src/${name} ]; then
          srcDir=$src/${name}
        else
          srcDir=$src
        fi
        cp -r $srcDir/* $dir/
        for f in $dir/{AUTHORS,COPYING,LICENSE,README,*.md,*.txt}; do
          test -f $f && mv $f $doc/
        done
        chmod 777 $dir/theme.conf

        ${lib.concatMapStringsSep "\n" (e: ''
          ${pkgs.crudini}/bin/crudini --set --inplace $dir/theme.conf \
            "${e.section}" "${e.key}" "${e.value}"
        '') themeIni}
      '';
    };

  customTheme = builtins.isAttrs theme;

  # ------------------------------------------
  # SDDM theme selector
  # ------------------------------------------

  # theme = "breeze"; # <==== Default ssdm them for kde
  # theme = themes.abstractdark;
  # theme = themes.delicious;
  # theme = themes.solarized;
  theme = themes.chili;

  themeName = if customTheme then theme.pkg.name else theme;

  packages = if customTheme then
    with pkgs;
    [
      (buildTheme theme.pkg)
      qt6.qtmultimedia
      libsForQt5.qt5.qtmultimedia
      libsForQt5.qt5.qtgraphicaleffects
      qt6.qtquick3d
      qt6.qtquicktimeline
      libsForQt5.qt5.qtquickcontrols
      qt6.qtquick3dphysics
      libsForQt5.qt5.qtquickcontrols2
      qt6.qtquickeffectmaker
      libsForQt5.sddm-kcm
      libsForQt5.phonon-backend-gstreamer
    ] ++ theme.deps
  else
    with pkgs; [
      qt6.qtmultimedia
      libsForQt5.qt5.qtmultimedia
      libsForQt5.qt5.qtgraphicaleffects
      qt6.qtquick3d
      qt6.qtquicktimeline
      libsForQt5.qt5.qtquickcontrols
      qt6.qtquick3dphysics
      libsForQt5.qt5.qtquickcontrols2
      qt6.qtquickeffectmaker
      libsForQt5.sddm-kcm
      libsForQt5.phonon-backend-gstreamer
    ];

  # packages = if customTheme then [ (buildTheme theme.pkg) ] ++ theme.deps else [ ];

  themes = {
    aerial = {
      pkg = rec {
        name = "aerial";
        version = "20191018";
        src = pkgs.fetchFromGitHub {
          owner = "3ximus";
          repo = "${name}-sddm-theme";
          rev = "1a8a5ba00aa4a98fcdc99c9c1547d73a2a64c1bf";
          sha256 = "0f62fqsr73d6fjpfhsdijin9pab0yn0phdyfqasybk50rn59861y";
        };
      };
      deps = with pkgs; [ qt5.qtmultimedia ];
    };

    abstractdark = {
      pkg = rec {
        name = "abstractdark";
        version = "20161002";
        src = pkgs.fetchFromGitHub {
          owner = "3ximus";
          repo = "${name}-sddm-theme";
          rev = "e817d4b27981080cd3b398fe928619ffa16c52e7";
          sha256 = "1si141hnp4lr43q36mbl3anlx0a81r8nqlahz3n3l7zmrxb56s2y";
        };
      };
      deps = with pkgs; [ ];
    };

    chili = {
      pkg = rec {
        name = "chili";
        version = "0.1.5";
        src = pkgs.fetchFromGitHub {
          owner = "MarianArlt";
          repo = "sddm-${name}";
          rev = version;
          sha256 = "036fxsa7m8ymmp3p40z671z163y6fcsa9a641lrxdrw225ssq5f3";
        };
        themeIni = [{
          section = "Theme";
          key = "FacesDir";
          value = /etc/nixos/SETUP/profile-pics/tolga.face.icon;
        }];
      };
      deps = with pkgs; [ ];
    };

    chilitwo = {
      pkg = rec {
        name = "chili";
        version = "0.1.5";
        src = ./chili;
      };
      deps = with pkgs; [ ];
    };

    deepin = {
      pkg = rec {
        name = "deepin";
        version = "20180306";
        src = pkgs.fetchFromGitHub {
          owner = "Match-Yang";
          repo = "sddm-${name}";
          rev = "6d018d2cad737018bb1e673ef4464ccf6a2817e7";
          sha256 = "1ghkg6gxyik4c03y1c97s7mjvl0kyjz9bxxpwxmy0rbh1a6xwmck";
        };
      };
      deps = with pkgs; [ qt5.qtmultimedia ];
    };

    delicious = {
      pkg = rec {
        name = "delicious";
        version = "1.0";
        src = pkgs.fetchFromGitHub {
          owner = "stuomas";
          repo = "sddm-${name}";
          rev = "fc98a56db6a61521cb2c55f2c50416f01f565ef7";
          sha256 = "sha256-XNejbRzPWzfsoPd5NkbOoibA5n7nm1CoNH+BO4w5tiA=";
        };

        themeIni = [{
          section = "General";
          key = "background";
          # value = ./assets/space.mp4;
          value = "";

        }];
      };
      deps = with pkgs; [ qt5.qtmultimedia ];
    };

    ittu = {
      pkg = rec {
        name = "ittu";
        version = "1.0";
        src = ./${name};
      };
      deps = with pkgs; [ ];
    };

    monochrome = {
      pkg = rec {
        name = "monochrome";
        version = "1.0";
        src = ./${name};
      };
      deps = with pkgs; [ ];
    };

    elegant = {
      pkg = rec {
        name = "Elegant";
        version = "20201105";
        src = ./elegant;
      };
      deps = with pkgs; [ ];
    };

    simple = {
      pkg = rec {
        name = "simple";
        version = "20201105";
        src = pkgs.fetchFromGitHub {
          owner = "niki-on-github";
          repo = "${name}-login-sddm-theme";
          rev = "032fd57a59233f1fe95a498954d884c3beb7414a";
          sha256 = "sha256-theaCZxtH67FhN3dT0NAQr/zFbBkvT6kzWY5hKJJK9o=";
        };
      };
      deps = with pkgs; [ ];
    };

    simplicity = {
      pkg = rec {
        name = "simplicity";
        version = "20190730";
        src = pkgs.fetchFromGitLab {
          owner = "isseigx";
          repo = "${name}-sddm-theme";
          rev = "d98fc1d03c44689883e27b57cc176b26d3316301";
          sha256 = "14wf62jgrpv4ybizbs57zma6kb4xy76qgl3wa38a5ykfgvpkcmrd";
        };
      };
      deps = with pkgs; [ noto-fonts ];
    };

    solarized = {
      pkg = rec {
        name = "solarized";
        version = "20190103";
        src = pkgs.fetchFromGitHub {
          owner = "MalditoBarbudo";
          repo = "${name}_sddm_theme";
          rev = "2b5bdf1045f2a5c8b880b482840be8983ca06191";
          sha256 = "1n36i4mr5vqfsv7n3jrvsxcxxxbx73yq0dbhmd2qznncjfd5hlxr";
        };
        themeIni = [{
          section = "General";
          key = "background";
          value = "bars_background.png";
        }];
      };
      deps = with pkgs; [ font-awesome ];
    };

    sugar-dark = {
      pkg = rec {
        name = "sugar-dark";
        version = "1.2";
        src = pkgs.fetchFromGitHub {
          owner = "MarianArlt";
          repo = "sddm-${name}";
          rev = "v${version}";
          sha256 = "0gx0am7vq1ywaw2rm1p015x90b75ccqxnb1sz3wy8yjl27v82yhb";
        };
      };
      deps = with pkgs; [ ];
    };
  };

in {
  environment.systemPackages = packages;

  services.xserver.displayManager.sddm.theme = themeName;
  services.xserver.displayManager.sddm.settings = {
    General = { InputMethod = " "; };
    Theme = { FacesDir = "/etc/nixos/SETUP/profile-pics/"; };
  };

  #  services.xserver.desktopManager.plasma5.enable = true;
}
