{ pkgs, ... }:
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
      XDG_CURRENT_DESKTOP = "hyprland";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      LIBVA_DRIVER_NAME = "nvidia";
      __GL_VRR_ALLOWED = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
      WLR_RENDERER_ALLOW_SOFTWARE = "1";
      CLUTTER_BACKEND = "wayland";
      WLR_RENDERER = "vulkan";
    };

    home.packages = with pkgs; [
      hyprland
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

    xdg.configFile."hypr/colors".text = ''
      $background = rgba(1d192bee)
      $foreground = rgba(c3dde7ee)

      $color0 = rgba(1d192bee)
      $color1 = rgba(465EA7ee)
      $color2 = rgba(5A89B6ee)
      $color3 = rgba(6296CAee)
      $color4 = rgba(73B3D4ee)
      $color5 = rgba(7BC7DDee)
      $color6 = rgba(9CB4E3ee)
      $color7 = rgba(c3dde7ee)
      $color8 = rgba(889aa1ee)
      $color9 = rgba(465EA7ee)
      $color10 = rgba(5A89B6ee)
      $color11 = rgba(6296CAee)
      $color12 = rgba(73B3D4ee)
      $color13 = rgba(7BC7DDee)
      $color14 = rgba(9CB4E3ee)
      $color15 = rgba(c3dde7ee)
    '';

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;

      extraConfig = ''
        # Monitor
        monitor=eDP-1,preferred,auto,2

        env = LIBVA_DRIVER_NAME,nvidia
        env = XDG_SESSION+TYPE,wayland
        env = GBM_BACKEND,nvidia-drm
        env = __GLX_VENDOR_LIBRARY_NAME,nvidia

        cursor {
          no_hardware_cursors = true
        }

        exec-once = swaybg -c 000000

        exec-once = copyq

        exec-once = udiskie

        source = ~/.config/hypr/colors
        exec = pkill waybar & sleep 0.5 && waybar

        input {
            follow_mouse = 1

            touchpad {
                natural_scroll = false
            }

            sensitivity = 0
        }

        general {
            gaps_in = 1
            gaps_out = 3
            border_size = 2
            col.active_border = rgba(e3c0a8ff)
            col.inactive_border = rgba(595959ff)

            layout = dwindle
        }

        decoration {
            rounding = 10
            drop_shadow = false
        }

        misc {
          vfr = false
        }

        animations {
            enabled = yes

            bezier = ease,0.4,0.02,0.21,1

            animation = windows, 1, 3.5, ease, slide
            animation = windowsOut, 1, 3.5, ease, slide
            animation = border, 1, 6, default
            animation = fade, 1, 3, ease
            animation = workspaces, 1, 3.5, ease
        }

        dwindle {
            pseudotile = yes
            preserve_split = yes
        }

        master {
            new_is_master = yes
        }

        gestures {
            workspace_swipe = false
        }

        windowrule=float,^(kitty)$
        windowrule=float,^(pavucontrol)$
        windowrule=center,^(kitty)$
        windowrule=float,^(blueman-manager)$
        windowrule=size 600 500,^(kitty)$
        windowrule=size 934 525,^(mpv)$
        windowrule=float,^(mpv)$
        windowrule=center,^(mpv)$

        $mod = SUPER
        $term = foot
        bind = $mod, G, fullscreen,

        bind = $mod, RETURN, exec, $term
        bind = $mod, Q, killactive,
        bind = $mod, M, exit,
        bind = $mod, V, togglefloating,
        bind = $mod, d, exec, rofi -show drun
        bind = $mod, P, pseudo,
        bind = $mod, J, togglesplit,

        bind = SUPER,B,exec,pkill waybar -10

        bind = SUPER_SHIFT,S,exec,grim -g "$(slurp)" - | wl-copy
        bind =,XF86AudioMicMute,exec,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
        binde =,XF86MonBrightnessDown,exec,light -U 10
        binde =,XF86MonBrightnessUp,exec,light -A 10
        bind =,XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        binde =,XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-
        binde =,XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+
        bind =,XF86AudioPlay,exec,playerctl play-pause
        bind =,XF86AudioPause,exec,playerctl play-pause

        bind = SUPER,Tab,cyclenext,
        bind = SUPER,Tab,bringactivetotop,

        bind = $mod, h, movefocus, l
        bind = $mod, l, movefocus, r
        bind = $mod, k, movefocus, u
        bind = $mod, j, movefocus, d

        bind = $mod, 1, workspace, 1
        bind = $mod, 2, workspace, 2
        bind = $mod, 3, workspace, 3
        bind = $mod, 4, workspace, 4
        bind = $mod, 5, workspace, 5
        bind = $mod, 6, workspace, 6
        bind = $mod, 7, workspace, 7
        bind = $mod, 8, workspace, 8
        bind = $mod, 9, workspace, 9
        bind = $mod, 0, workspace, 10

        bind = $mod SHIFT, 1, movetoworkspace, 1
        bind = $mod SHIFT, 2, movetoworkspace, 2
        bind = $mod SHIFT, 3, movetoworkspace, 3
        bind = $mod SHIFT, 4, movetoworkspace, 4
        bind = $mod SHIFT, 5, movetoworkspace, 5
        bind = $mod SHIFT, 6, movetoworkspace, 6
        bind = $mod SHIFT, 7, movetoworkspace, 7
        bind = $mod SHIFT, 8, movetoworkspace, 8
        bind = $mod SHIFT, 9, movetoworkspace, 9
        bind = $mod SHIFT, 0, movetoworkspace, 10

        bind = $mod, mouse_down, workspace, e+1
        bind = $mod, mouse_up, workspace, e-1

        bindm = $mod, mouse:272, movewindow
        bindm = $mod, mouse:273, resizewindow
        bindm = ALT, mouse:272, resizewindow
      '';
    };
  };
}
