{ pkgs, inputs, ... }:

{
  # Web Browsers:
  environment = { systemPackages = with pkgs; [ firefox google-chrome ]; };

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
          "identity.fxaccounts.enabled" = false;
          "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
          "signon.rememberSignons" = false;
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
