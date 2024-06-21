{
  lib,
  pkgs,
  inputs,
  ...
}: let
  left = "h";
  down = "j";
  up = "k";
  right = "l";

  fonts = {
    names = ["Inter"];
    style = "Regular";
    size = 10.0;
  };

  # menu = "${pkgs.rofi-wayland}/bin/rofi -terminal ${terminal} -show drun -theme sidestyle -show-icons -icon-theme Paper";


in {
  imports = [];

  environment.systemPackages = with pkgs; [
    capitaine-cursors
  ];

  # Apparently required for GTK3 settings on sway
  programs.dconf.enable = true;

  xdg.portal.config.common.default = "*"; 
  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;
  xdg.portal.extraPortals = [
    # Default portal
    pkgs.xdg-desktop-portal-gtk
    # Screencasting support
    pkgs.xdg-desktop-portal-gnome
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  users.users.baba.packages = [pkgs.swaybg];

  home-manager.users.baba = {pkgs, ...}: {
    imports = [./waybar ./wlsunset];

    # rofi menu style
    xdg.configFile."rofi/sidestyle.rasi".source = ./sidestyle.rasi;

    # Starts automatically via dbus
    services.mako = {
      enable = true;
      font = "Inter UI, Font Awesome 10";
      padding = "15,20";
      # backgroundColor = "#3b224cF0";
      backgroundColor = "#281733F0";
      textColor = "#ebeafa";
      borderSize = 2;
      borderColor = "#a4a0e8";
      defaultTimeout = 5000;
      markup = true;
      format = "<b>%s</b>\\n\\n%b";

      # TODO:
      # [hidden]
      # format=(and %h more)
      # text-color=#999999

      # [urgency=high]
      # text-color=#F22C86
      # border-color=#F22C86
      # border-size=4
    };

    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      MOZ_USE_XINPUT2 = "1";

      SDL_VIDEODRIVER = "wayland";
      # needs qt5.qtwayland in systemPackages
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      _JAVA_AWT_WM_NONREPARENTING = "1";

      # XDG_SESSION_TYPE = "wayland"; now set by wlroots https://github.com/nix-community/home-manager/commit/2464c21ab2b3607bed3c206a436855c487f35f55
      XDG_CURRENT_DESKTOP = "hyprland";

      GBM_BACKEND= "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME= "nvidia";
      LIBVA_DRIVER_NAME= "nvidia"; # hardware acceleration
      __GL_VRR_ALLOWED="1";
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
      # alacritty
      libnotify
      mako
      # volnoti
      wl-clipboard
      waybar
      grim
      slurp
      # ydotool-git
      pulseaudio # just for pactl, wish there was pulseaudio-util
      playerctl
    ];

    xdg.configFile."hypr/colors".text =
''$background = rgba(1d192bee)
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

          # Fix slow startup
          # exec systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
          # exec dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP 

          # Autostart

          # exec-once = hyprctl setcursor Bibata-Modern-Classic 24
          exec-once = swaybg -c 000000

          source = ~/.config/hypr/colors
          # exec = pkill waybar & sleep 0.5 && waybar
          # exec-once = swww init & sleep 0.5 && exec wallpaper_random
          # exec-once = wallpaper_random

          # Set en layout at startup

          # Input config
          input {
              # kb_layout = en,us
              # kb_variant =
              # kb_model =
              # kb_options =
              # kb_rules =

              follow_mouse = 1

              touchpad {
                  natural_scroll = false
              }

              sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
          }

          general {

              gaps_in = 1
              gaps_out = 3
              border_size = 2
              col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
              col.inactive_border = rgba(595959aa)

              layout = dwindle
          }

          decoration {

              rounding = 10
              # blur = true
              # blur_size = 3
              # blur_passes = 1
              # blur_new_optimizations = true

              drop_shadow = true
              shadow_range = 4
              shadow_render_power = 3
              col.shadow = rgba(1a1a1aee)
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

          # Example windowrule v1
          # windowrule = float, ^(kitty)$
          # Example windowrule v2
          # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$

          windowrule=float,^(kitty)$
          windowrule=float,^(pavucontrol)$
          windowrule=center,^(kitty)$
          windowrule=float,^(blueman-manager)$
          windowrule=size 600 500,^(kitty)$
          windowrule=size 934 525,^(mpv)$
          windowrule=float,^(mpv)$
          windowrule=center,^(mpv)$
          #windowrule=pin,^(firefox)$

          $mod = SUPER
          $term = foot
          bind = $mod, G, fullscreen,


          bind = $mod, RETURN, exec, $term
          bind = $mod, Q, killactive,
          bind = $mod, M, exit,
          bind = $mod, V, togglefloating,
          bind = $mod, d, exec, rofi -show drun
          bind = $mod, P, pseudo, # dwindle
          bind = $mod, J, togglesplit, # dwindle

          # Switch Keyboard Layouts
          # bind = $mod, SPACE, exec, hyprctl switchxkblayout teclado-gamer-husky-blizzard next

          bind = SUPER,B,exec,pkill waybar -10

          # Functional keybinds
          bind = ,code:133&code:62&code:39,exec,grim -g "$(slurp)" - | wl-copy
          bind =,XF86AudioMicMute,exec,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
          binde =,XF86MonBrightnessDown,exec,light -U 10
          binde =,XF86MonBrightnessUp,exec,light -A 10
          bind =,XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
          binde =,XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-
          binde =,XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+
          bind =,XF86AudioPlay,exec,playerctl play-pause
          bind =,XF86AudioPause,exec,playerctl play-pause

          # to switch between windows in a floating workspace
          bind = SUPER,Tab,cyclenext,
          bind = SUPER,Tab,bringactivetotop,

          # Move focus with mod + arrow keys
          bind = $mod, h, movefocus, l
          bind = $mod, l, movefocus, r
          bind = $mod, k, movefocus, u
          bind = $mod, j, movefocus, d

          # Switch workspaces with mod + [0-9]
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

          # Move active window to a workspace with mod + SHIFT + [0-9]
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

          # Scroll through existing workspaces with mod + scroll
          bind = $mod, mouse_down, workspace, e+1
          bind = $mod, mouse_up, workspace, e-1

          # Move/resize windows with mod + LMB/RMB and dragging
          bindm = $mod, mouse:272, movewindow
          bindm = $mod, mouse:273, resizewindow
          bindm = ALT, mouse:272, resizewindow
          
        '';

      };

    
  };
}
