{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    hyprlock
    hypridle
  ];

  xdg.configFile = with config.lib.stylix.colors; {
    "hypr/hyprlock.conf".text =
      let
        rgb = color: "rgb(${color})";
      in
      ''
        background {
          monitor =
          path = 
          color = ${rgb base00}
        }

        input-field {
          monitor =
          size = 200, 50
          outline_thickness = 3
          dots_size = 0.33 # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.15 # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = false
          dots_rounding = -1 # -1 default circle, -2 follow input-field rounding
          outer_color = ${rgb base04}
          inner_color = ${rgb base01}
          font_color = ${rgb base05}
          fade_on_empty = true
          fade_timeout = 0 # Milliseconds before fade_on_empty is triggered.
          placeholder_text = <i>Input Password...</i> # Text rendered in the input box when it's empty.
          hide_input = false
          rounding = -1 # -1 means complete rounding (circle/oval)
          check_color = ${rgb base06}
          fail_color = ${rgb base08} # if authentication failed, changes outer_color and fail message color
          fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i> # can be set to empty
          fail_transition = 300 # transition time in ms between normal outer_color and fail_color
          capslock_color = -1
          numlock_color = -1
          bothlock_color = -1 # when both locks are active. -1 means don't change outer color (same for above)
          invert_numlock = false # change color if numlock is off
          swap_font_color = false # see below

          position = 0, -20
          halign = center
          valign = center
        }
      '';
    # timeout is in seconds
    "hypr/hypridle.conf".text = ''
      general {
        lock_cmd = pidof hyprlock || hyprlock       # avoid starting multiple hyprlock instances.
        before_sleep_cmd = loginctl lock-session    # lock before suspend.
        after_sleep_cmd = hyprctl dispatch dpms on  # to avoid having to press a key twice to turn on the display.
      }

      listener {
        timeout = 290                                # 2.5min.
        on-timeout = brightnessctl -s set 10         # set monitor backlight to minimum, avoid 0 on OLED monitor.
        on-resume = brightnessctl -r                 # monitor backlight restore.
      }

      # turn off keyboard backlight, comment out this section if you dont have a keyboard backlight.
      listener {
        timeout = 150                                          # 2.5min.
        on-timeout = brightnessctl -sd rgb:kbd_backlight set 0 # turn off keyboard backlight.
        on-resume = brightnessctl -rd rgb:kbd_backlight        # turn on keyboard backlight.
      }

      listener {
        timeout = 1800                                 # 30 mins
        on-timeout = loginctl lock-session            # lock screen when timeout has passed
      }

      listener {
        timeout = 1900                                 # 30 mins + d
        on-timeout = hyprctl dispatch dpms off        # screen off when timeout has passed
        on-resume = hyprctl dispatch dpms on          # screen on when activity is detected after timeout has fired.
      }

      listener {
        timeout = 3600                                # 1hr
        on-timeout = systemctl suspend                # suspend pc
      }
    '';
  };
}

