{ pkgs, ... }:
let
  left = "h";
  down = "j";
  up = "k";
  right = "l";

  fonts = {
    names = [ "Inter" ];
    style = "Regular";
    size = 10.0;
  };
  terminal = "${pkgs.wezterm}/bin/wezterm";
  browser = "${pkgs.firefox-wayland}/bin/firefox";
  file_browser = "${pkgs.xplr}/bin/xplr";

  menu = "${pkgs.rofi-wayland}/bin/rofi -terminal ${terminal} -show drun -theme sidestyle -show-icons -icon-theme Paper";

  _touchpad = {
    left_handed = "enabled";
    click_method = "clickfinger";
    tap = "disabled";
    dwt = "enabled";
    scroll_method = "two_finger";
    natural_scroll = "enabled";
    scroll_factor = "0.75";
    accel_profile = "adaptive";
  };
  _keyboard = {
    xkb_layout = "us";
    xkb_variant = "norman";
    xkb_options = "compose:ralt";
  };

  in_touchpad = "1118:2479:Microsoft_Surface_045E:09AF_Touchpad";
  in_keyboard = "1118:2478:Microsoft_Surface_045E:09AE_Keyboard";
  in_ergodox = "12951:18804:ZSA_Technology_Labs_ErgoDox_EZ_Keyboard";
  in_mouse = "1133:16518:Logitech_G703_LS";
  out_laptop = "eDP-1";
  out_monitor = "DP-1";
in
{
  home-manager.users.baba = {
    imports = [
      ./waybar
      ./wlsunset
    ];

    xdg.configFile."rofi/sidestyle.rasi".source = ./sidestyle.rasi;

    services.mako = {
      enable = true;
      font = "Inter UI, Font Awesome 10";
      padding = "15,20";
      backgroundColor = "#281733F0";
      textColor = "#ebeafa";
      borderSize = 2;
      borderColor = "#a4a0e8";
      defaultTimeout = 5000;
      markup = true;
      format = "<b>%s</b>\\n\\n%b";
    };

    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      MOZ_USE_XINPUT2 = "1";
      SDL_VIDEODRIVER = "wayland";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      XDG_CURRENT_DESKTOP = "sway";
    };

    home.packages = with pkgs; [
      swaylock
      swayidle
      xwayland
      rofi-wayland
      libinput-gestures
      qt5.qtwayland
      libnotify
      mako
      wl-clipboard
      waybar
      grim
      slurp
      pulseaudio
      playerctl
    ];

    wayland.windowManager.sway = {
      enable = true;
      systemd.enable = true;
      wrapperFeatures = {
        base = true;
        gtk = true;
      };
      xwayland = true;
      extraConfig = ''
        set $bg #281733
        set $fg #eff1f5
        set $br #a4a0e8
        set $ia #232425

        client.focused          $br     $br     $bg     $bg       $br
        client.focused_inactive $bg     $bg     $fg     $bg       $bg
        client.unfocused        $bg     $bg     $fg     $bg       $bg
        client.urgent           $br     $br     $fg     $bg       $br
        client.placeholder      $br     $br     $fg     $bg       $br
        client.background $bg

        seat seat0 xcursor_theme "capitaine-cursors"

        for_window [title="Firefox — Sharing Indicator"] floating enable
        for_window [title="Firefox — Sharing Indicator"] nofocus
      '';
      config = rec {
        modifier = "Mod4";
        inherit terminal menu;
        inherit left up right down fonts;

        focus.followMouse = "always";

        window = {
          titlebar = false;
          border = 3;
          commands = [
            {
              criteria = { app_id = "mpv"; };
              command = "sticky enable";
            }
            {
              criteria = { app_id = "mpv"; };
              command = "floating enable";
            }
          ];
        };

        floating = {
          titlebar = false;
          border = 0;
        };

        gaps = {
          outer = 5;
          inner = 10;
          smartGaps = true;
          smartBorders = "no_gaps";
        };

        startup = [ ];

        input = {
          "type:touchpad" = _touchpad;
          "${in_keyboard}" = _keyboard;
          "1:1:AT_Translated_Set_2_keyboard" = _keyboard;
          "${in_mouse}" = {
            accel_profile = "adaptive";
            pointer_accel = "-0.2";
          };
          "${in_ergodox}" = {
            xkb_options = "compose:ralt";
          };
        };

        output = {
          "${out_laptop}" = {
            scale = "1.498";
          };
          "${out_monitor}" = {
            mode = "3840x2160@60.000Hz";
            scale = "1.5";
          };
          "*" = {
            background = "#185373 solid_color";
          };
        };

        bars = [ ];

        keycodebindings = {
          "102" = "exec ydotool key tab";
          "100" = "exec ydotool key backspace";
          "101" = "exec ydotool key enter";
        };

        keybindings = {
          "${modifier}+Return" = "exec ${terminal}";
          "${modifier}+Shift+b" = "exec ${browser}";
          "${modifier}+Shift+q" = "kill";
          "${modifier}+d" = "exec ${menu}";
          "${modifier}+z" = "exec ${terminal} -e ${file_browser}";
          "Ctrl+q" = "exec echo";
          "${modifier}+Shift+c" = "reload";
          "${modifier}+Shift+e" = "exec 'swaymsg exit'";
          "${modifier}+${left}" = "focus left";
          "${modifier}+${down}" = "focus down";
          "${modifier}+${up}" = "focus up";
          "${modifier}+${right}" = "focus right";
          "${modifier}+Shift+${left}" = "move left";
          "${modifier}+Shift+${down}" = "move down";
          "${modifier}+Shift+${up}" = "move up";
          "${modifier}+Shift+${right}" = "move right";
          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";
          "${modifier}+Shift+1" = "move container to workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6";
          "${modifier}+Shift+7" = "move container to workspace number 7";
          "${modifier}+Shift+8" = "move container to workspace number 8";
          "${modifier}+Shift+9" = "move container to workspace number 9";
          "${modifier}+b" = "splith";
          "${modifier}+v" = "splitv";
          "${modifier}+s" = "layout stacking";
          "${modifier}+w" = "layout tabbed";
          "${modifier}+e" = "layout toggle split";
          "${modifier}+f" = "fullscreen toggle";
          "${modifier}+a" = "focus parent";
          "${modifier}+Shift+space" = "floating toggle";
          "${modifier}+Shift+Alt+space" = "sticky toggle";
          "${modifier}+space" = "focus mode_toggle";
          "${modifier}+Shift+minus" = "move scratchpad";
          "${modifier}+minus" = "scratchpad show";
          "${modifier}+r" = "mode resize";
        };
      };
    };
  };
}
