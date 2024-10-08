{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = pkgs.lib.readFile ./style.css;
    settings = [
      {
        layer = "top";
        height = 30;
        modules-left = ["sway/mode" "pulseaudio" "custom/wlsunset" "custom/weather"];
        modules-center = ["sway/workspaces"];
        modules-right = ["tray" "idle_inhibitor" "cpu" "memory" "network" "temperature" "battery" "clock"];
        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = false;
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "4";
            "5" = "5";
            "6" = "";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            # "urgent" = "";
            # "focused" = "";
            # "default" = "";
          };
          # "persistant_workspaces": {
          #     "1": ["eDP-1"],
          #     "2": ["eDP-1"],
          #     "6": ["eDP-1"],
          #     "9": ["eDP-1"]
          # }
        };
        "sway/mode" = {
          # format = '<span style=\"italic\">{}</span>';
        };
        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        tray = {
          icon-size = 16;
          spacing = 10;
        };
        clock = {
          tooltip-format = "{:%Y-%m-%d | %H:%M}";
          format-alt = "{:%a, %d %b %Y}";
        };
        cpu = {
          format = "{usage}% ";
          tooltip = false;
        };
        memory = {
          format = "{}% ";
        };
        temperature = {
          # thermal-zone = 5;
          hwmon-path = "/sys/class/hwmon/hwmon2/temp2_input"; # Tdie
          critical-threshold = 80;
          # "format-critical": "{temperatureC}°C {icon}",
          format = "{temperatureC}°C {icon}";
          format-icons = ["" "" "" "" ""];
        };
        # backlight = {
        #     # "device": "acpi_video1",
        #     format = "{percent}% {icon}";
        #     format-icons = ["" ""];
        # };
        battery = {
          states = {
            # "good": 95,
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          # "format-good": "", # An empty format will hide the module
          # "format-full": "",
          format-icons = ["" "" "" "" ""];
          bat = "BAT1";
        };
        # "battery#bat1" = {
        #     states = {
        #         # "good": 95,
        #         warning = 30;
        #         critical = 15;
        #     };
        #     format = "{capacity}% {icon}";
        #     format-charging = "{capacity}% ";
        #     format-plugged = "{capacity}% ";
        #     format-alt = "{time} {icon}";
        #     # "format-good": "", # An empty format will hide the module
        #     # "format-full": "",
        #     format-icons = ["" "" "" "" ""];
        #     bat = "BAT0";
        # };
        network = {
          # "interface": "wlp2*", # (Optional) To force the use of this interface
          format-wifi = "{signalStrength}% ";
          format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{essid} {signalStrength}%";
        };
        pulseaudio = {
          # "scroll-step": 1, # %, can be a float
          format = "{volume}% {icon}   {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-muted = "   {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphones = "";
            handsfree = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        };
        "custom/wlsunset" = {
          format = "";
          on-click = pkgs.writeShellScript "wlsunset" ''
            if systemctl is-active --quiet --user wlsunset; then
               systemctl --user stop wlsunset
            else
               systemctl --user start wlsunset
            fi
          '';
        };
      }
    ];
  };
}
