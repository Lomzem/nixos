{ pkgs, ... }:

let
  home = "/home/lomzem";

  action = name: {
    action.${name} = [ ];
  };
in
{
  home = {
    sessionVariables = {
      XDG_DATA_HOME = "${home}/.local/share";
      XDG_CONFIG_HOME = "${home}/.config";
      XDG_CACHE_HOME = "${home}/.cache";
      XDG_STATE_HOME = "${home}/.local/state";

      CARGO_HOME = "${home}/.local/share/cargo";
      GNUPGHOME = "${home}/.local/share/gnupg";
      GOMODCACHE = "${home}/.cache/go/mod";
      GOPATH = "${home}/.local/share/go";
      NPM_CONFIG_USERCONFIG = "${home}/.config/npm/npmrc";
      PYTHON_HISTORY = "${home}/.local/state/python_history";
      RUSTUP_HOME = "${home}/.local/share/rustup";
      TEXMFCONFIG = "${home}/.config/texlive/texmf-config";
      TEXMFHOME = "${home}/.local/share/texmf";
      TEXMFVAR = "${home}/.cache/texlive/texmf-var";
      WGETRC = "${home}/.config/wgetrc";
    };

    packages = with pkgs; [
      brightnessctl
      fuzzel
      kitty
      qutebrowser
    ];
  };

  xdg.enable = true;
  xdg.configFile.niri-config.force = true;

  programs.niri.settings = {
    input = {
      mod-key = "Super";
      focus-follows-mouse.enable = true;

      keyboard = {
        xkb.layout = "us";
        repeat-delay = 175;
        repeat-rate = 45;
      };
    };

    environment = {
      BROWSER = "helium-browser";
      CHROME_EXECUTABLE = "helium-browser";
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      ELM_DISPLAY = "wl";
      SDL_VIDEODRIVER = "wayland,x11";
      XDG_SESSION_TYPE = "wayland";
      MANPAGER = ''nvim "+Man!"'';
    };

    layout = {
      gaps = 8;
      center-focused-column = "never";
      preset-column-widths = [
        { proportion = 0.5; }
      ];
      default-column-width = {
        proportion = 1.0;
      };

      focus-ring.width = 2;
      border.enable = false;

      shadow = {
        enable = false;
        softness = 30;
        spread = 5;
        offset = {
          x = 0;
          y = 5;
        };
        color = "#0007";
      };
    };

    hotkey-overlay.skip-at-startup = true;
    prefer-no-csd = true;
    screenshot-path = "~/ss-%Y-%m-%d-%H-%M-%S.png";
    animations.slowdown = 0.5;

    window-rules = [
      {
        geometry-corner-radius =
          let
            radius = 12.0;
          in
          {
            top-left = radius;
            top-right = radius;
            bottom-right = radius;
            bottom-left = radius;
          };
        clip-to-geometry = true;
      }
    ];

    binds = {
      "Mod+Shift+Slash" = action "show-hotkey-overlay";

      "Mod+Q" = {
        hotkey-overlay.title = "Open a Terminal";
        action.spawn = [
          "kitty"
        ];
      };
      "Mod+B" = {
        hotkey-overlay.title = "Open a Browser";
        action.spawn = "helium-browser";
      };
      "Mod+P" = {
        hotkey-overlay.title = "Run an Application: fuzzel";
        action.spawn-sh = "fuzzel --list-executables-in-path";
      };

      "XF86AudioRaiseVolume" = {
        allow-when-locked = true;
        action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+";
      };
      "XF86AudioLowerVolume" = {
        allow-when-locked = true;
        action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
      };
      "XF86AudioMute" = {
        allow-when-locked = true;
        action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      };
      "XF86AudioMicMute" = {
        allow-when-locked = true;
        action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
      };

      "XF86MonBrightnessUp" = {
        allow-when-locked = true;
        action.spawn = [
          "brightnessctl"
          "--class=backlight"
          "set"
          "+10%"
        ];
      };
      "XF86MonBrightnessDown" = {
        allow-when-locked = true;
        action.spawn = [
          "brightnessctl"
          "--class=backlight"
          "set"
          "10%-"
        ];
      };

      "Ctrl+Shift+R" = action "toggle-window-rule-opacity";
      "Mod+O" = (action "toggle-overview") // { repeat = false; };
      "Mod+Shift+C" = (action "close-window") // { repeat = false; };

      "Mod+H" = action "focus-column-left";
      "Mod+L" = action "focus-column-right";
      "Mod+Ctrl+H" = action "move-column-left";
      "Mod+Ctrl+L" = action "move-column-right";
      "Mod+Shift+H" = action "focus-monitor-left";
      "Mod+Shift+L" = action "focus-monitor-right";
      "Mod+Shift+Ctrl+H" = action "move-column-to-monitor-left";
      "Mod+Shift+Ctrl+L" = action "move-column-to-monitor-right";

      "Mod+J" = action "focus-workspace-down";
      "Mod+K" = action "focus-workspace-up";
      "Mod+Shift+J" = action "move-column-to-workspace-down";
      "Mod+Shift+K" = action "move-column-to-workspace-up";

      "Mod+WheelScrollDown" = (action "focus-workspace-down") // { cooldown-ms = 150; };
      "Mod+WheelScrollUp" = (action "focus-workspace-up") // { cooldown-ms = 150; };
      "Mod+Ctrl+WheelScrollDown" = (action "move-column-to-workspace-down") // { cooldown-ms = 150; };
      "Mod+Ctrl+WheelScrollUp" = (action "move-column-to-workspace-up") // { cooldown-ms = 150; };

      "Mod+WheelScrollRight" = action "focus-column-right";
      "Mod+WheelScrollLeft" = action "focus-column-left";
      "Mod+Ctrl+WheelScrollRight" = action "move-column-right";
      "Mod+Ctrl+WheelScrollLeft" = action "move-column-left";
      "Mod+Shift+WheelScrollDown" = action "focus-column-right";
      "Mod+Shift+WheelScrollUp" = action "focus-column-left";
      "Mod+Ctrl+Shift+WheelScrollDown" = action "move-column-right";
      "Mod+Ctrl+Shift+WheelScrollUp" = action "move-column-left";

      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;
      "Mod+Shift+1".action.move-column-to-workspace = 1;
      "Mod+Shift+2".action.move-column-to-workspace = 2;
      "Mod+Shift+3".action.move-column-to-workspace = 3;
      "Mod+Shift+4".action.move-column-to-workspace = 4;
      "Mod+Shift+5".action.move-column-to-workspace = 5;
      "Mod+Shift+6".action.move-column-to-workspace = 6;
      "Mod+Shift+7".action.move-column-to-workspace = 7;
      "Mod+Shift+8".action.move-column-to-workspace = 8;
      "Mod+Shift+9".action.move-column-to-workspace = 9;

      "Mod+Tab" = action "focus-workspace-previous";
      "Mod+BracketLeft" = action "consume-or-expel-window-left";
      "Mod+BracketRight" = action "consume-or-expel-window-right";
      "Mod+Comma" = action "consume-window-into-column";
      "Mod+Period" = action "expel-window-from-column";
      "Mod+R" = action "switch-preset-column-width";
      "Mod+Shift+R" = action "switch-preset-window-height";
      "Mod+Ctrl+R" = action "reset-window-height";
      "Mod+F" = action "maximize-column";
      "Mod+Shift+F" = action "fullscreen-window";
      "Mod+Ctrl+F" = action "expand-column-to-available-width";
      "Mod+C" = action "center-column";
      "Mod+Ctrl+C" = action "center-visible-columns";

      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width = "+10%";
      "Mod+Shift+Minus".action.set-window-height = "-10%";
      "Mod+Shift+Equal".action.set-window-height = "+10%";

      "Mod+V" = action "toggle-window-floating";
      "Mod+Shift+V" = action "switch-focus-between-floating-and-tiling";
      "Mod+W" = action "toggle-column-tabbed-display";

      "Print" = action "screenshot";
      "Super+Shift+S" = action "screenshot";
      "Ctrl+Print" = action "screenshot-screen";
      "Alt+Print" = action "screenshot-window";

      "Mod+Escape" = {
        allow-inhibiting = false;
        action.toggle-keyboard-shortcuts-inhibit = [ ];
      };
      "Mod+Shift+E" = action "quit";
      "Ctrl+Alt+Delete" = action "quit";
      "Mod+Shift+P" = action "power-off-monitors";

      "Alt+Shift+P" = {
        hotkey-overlay.title = "PDF Search";
        action.spawn-sh = "$HOME/dotfiles/.local/bin/pdf-search.sh";
      };
      "Alt+Shift+B" = {
        hotkey-overlay.title = "Bookmarks";
        action.spawn-sh = "$HOME/dotfiles/.local/bin/custom-scripts/bookmarks/bookmarks.sh";
      };
    };
  };
}
