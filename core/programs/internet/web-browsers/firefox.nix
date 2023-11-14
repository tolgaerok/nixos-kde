{ pkgs, inputs, ... }:

{
 # FireFox program settings

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
              template = "https://search.nixos.org/packages?query=%s";
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
          "gfx.webrender.enabled" = true;
          "layout.css.backdrop-filter.enabled" = true;
          "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
          "signon.rememberSignons" = false;
          "svg.context-properties.content.enabled" = true;

          # We handle this elsewhere
          "browser.shell.checkDefaultBrowser" = false;

          # Don't allow websites to prevent use of right-click, or otherwise
          # messing with the context menu.
          "dom.event.contextmenu.enabled" = true;

          # Don't allow websites to prevent copy and paste. Disable
          # notifications of copy, paste, or cut functions. Stop webpage
          # knowing which part of the page had been selected.
          "dom.event.clipboardevents.enabled" = true;

          # Do not track from battery status.
          "dom.battery.enabled" = false;

          # Show punycode. Help protect from character 'spoofing'.
          "network.IDN_show_punycode" = true;

          # Disable site reading installed plugins.
          "plugins.enumerable_names" = "";

          # Use Mozilla instead of Google here.
          "geo.provider.network.url" =
            "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";

          # No speculative content when searching.
          "browser.urlbar.speculativeConnect.enabled" = false;

          # Sends data to servers when leaving pages.
          "beacon.enabled" = false;
          # Informs servers about links that get clicked on by the user.
          "browser.send_pings" = false;

          "browser.tabs.closeWindowWithLastTab" = false;
          "browser.urlbar.placeholderName" = "DuckDuckGo";
          "browser.search.defaultenginename" = "DuckDuckGo";

          # Safe browsing
          "browser.safebrowsing.enabled" = false;
          "browser.safebrowsing.phishing.enabled" = false;
          "browser.safebrowsing.malware.enabled" = false;
          "browser.safebrowsing.downloads.enabled" = false;
          "browser.safebrowsing.provider.google4.updateURL" = "";
          "browser.safebrowsing.provider.google4.reportURL" = "";
          "browser.safebrowsing.provider.google4.reportPhishMistakeURL" = "";
          "browser.safebrowsing.provider.google4.reportMalwareMistakeURL" = "";
          "browser.safebrowsing.provider.google4.lists" = "";
          "browser.safebrowsing.provider.google4.gethashURL" = "";
          "browser.safebrowsing.provider.google4.dataSharingURL" = "";
          "browser.safebrowsing.provider.google4.dataSharing.enabled" = false;
          "browser.safebrowsing.provider.google4.advisoryURL" = "";
          "browser.safebrowsing.provider.google4.advisoryName" = "";
          "browser.safebrowsing.provider.google.updateURL" = "";
          "browser.safebrowsing.provider.google.reportURL" = "";
          "browser.safebrowsing.provider.google.reportPhishMistakeURL" = "";
          "browser.safebrowsing.provider.google.reportMalwareMistakeURL" = "";
          "browser.safebrowsing.provider.google.pver" = "";
          "browser.safebrowsing.provider.google.lists" = "";
          "browser.safebrowsing.provider.google.gethashURL" = "";
          "browser.safebrowsing.provider.google.advisoryURL" = "";
          "browser.safebrowsing.downloads.remote.url" = "";

          # Don't call home on new tabs
          "browser.selfsupport.url" = "";
          "browser.aboutHomeSnippets.updateUrL" = "";
          "browser.startup.homepage_override.mstone" = "ignore";
          "browser.startup.homepage_override.buildID" = "";
          "startup.homepage_welcome_url" = "";
          "startup.homepage_welcome_url.additional" = "";
          "startup.homepage_override_url" = "";

          # Firefox experiments...
          "experiments.activeExperiment" = false;
          "experiments.enabled" = false;
          "experiments.supported" = false;
          "extensions.pocket.enabled" = false;
          "identity.fxaccounts.enabled" = false;

          # Privacy
          "privacy.donottrackheader.enabled" = true;
          "privacy.donottrackheader.value" = 1;
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;
          "privacy.firstparty.isolate" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.archive.enabled" = false;
          "browser.toolbars.bookmarks.visibility" = "never";

          # Cookies
          "network.cookie.cookieBehavior" = 1;

          # Perf
          "gfx.webrender.all" = true;
          "media.ffmpeg.vaapi.enabled" = true;
          "media.ffvpx.enabled" = false;
          "media.rdd-vpx.enabled" = false;
          "gfx.webrender.compositor.force-enabled" = true;
          "media.navigator.mediadatadecoder_vpx_enabled" = true;
          "webgl.force-enabled" = true;
          "layers.acceleration.force-enabled" = true;
          "layers.offmainthreadcomposition.enabled" = true;
          "layers.offmainthreadcomposition.async-animations" = true;
          "layers.async-video.enabled" = true;
          "html5.offmainthread" = true;

          

        };

        # userChrome = ''
        #   /* some css */                        
        # '';
        # modified theme from https://github.com/Bali10050/FirefoxCSS
        # userChrome = builtins.readFile ./userChrome.css;
        # userContent = builtins.readFile ./userContent.css;
      };
    };
    # };
  };

  nixpkgs.config.firefox.enablePlasmaBrowserIntegration = true;

}
# NOTE: 
# FireFox custom CSS files
# Enable toolkit.legacyUserProfileCustomizations.stylesheets
#   Go to about:config
#   Click on „Accept the Risk and Continue”
#   Doubleclick on toolkit.legacyUserProfileCustomizations.stylesheets if it isn't already enabled to true:
#   Copy the CSS in your profiles chrome folder
#   Go to about:profiles
#   Find your profile -- ( „This is the profile in use and it cannot be deleted.” )
#     Open the profiles root directory
#     Create a folder called chrome
#     Copy the preferred  
#     userChrome.css 
#         and  
#     userContent.css 
#       in there
#   Restart Firefox