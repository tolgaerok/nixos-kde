{ pkgs, inputs, ... }:

{
  # Web Browsers & Plasma plasma-integration add-ons
  environment = {
    systemPackages = with pkgs; [
      # kdeplasma-addons
      # plasma-integration
      firefox
      google-chrome
      plasma-browser-integration
    ];
  };

  programs = {
    firefox = {
      enable = true;
      # profiles.default = {
      policies = {
        CaptivePortal = false;
        DisableFirefoxAccounts = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        PasswordManagerEnabled = true;

        FirefoxHome = {
          Highlights = false;
          Pocket = false;
          Search = true;
          Snippets = false;
          TopSites = false;
        };

        UserMessaging = {
          ExtensionRecommendations = false;
          SkipOnboarding = true;
        };

        search.engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }];

            icon =
              "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
        };

        search.force = true;

        bookmarks = [{
          name = "wikipedia";
          tags = [ "wiki" ];
          keyword = "wiki";
          url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
        }];

        settings = {

          "browser.download.panel.shown" = true;
          "dom.security.https_only_mode" = true;
          "general.smoothScroll" = true;
          "gfx.webrender.all" = true;
          "gfx.webrender.enabled" = true;
          "identity.fxaccounts.enabled" = false;
          "layers.acceleration.force-enabled" = true;
          "layout.css.backdrop-filter.enabled" = true;
          "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
          "signon.rememberSignons" = false;
          "svg.context-properties.content.enabled" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        };

        # userChrome = ''
        #   /* some css */                        
        # '';
        # modified theme from https://github.com/Bali10050/FirefoxCSS
        userChrome = builtins.readFile ./userChrome.css;
        userContent = builtins.readFile ./userContent.css;
      };
    };
    # };
  };

  nixpkgs.config.firefox.enablePlasmaBrowserIntegration = true;

}
