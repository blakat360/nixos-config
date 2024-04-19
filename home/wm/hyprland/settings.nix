{
  "$mainMod" = "SUPER";
  "$terminal" = "kitty";
  "$menu" = "wofi --show drun";

  exec-once = [
    "waybar"
    "hypridle"
  ];

  env = [
    "XCURSOR_SIZE,2"
    "QT_QPA_PLATFORMTHEME,qt5ct" # change to qt6ct if you have that
  ];

  monitor = [
    "eDP-1, 3840x2160@60, 0x0, 1.00"
  ];

  input = {
    kb_layout = "us";
    kb_variant = " ";
    kb_model = " ";
    kb_options = "caps:escape";
    kb_rules = " ";

    follow_mouse = 1;

    touchpad =
      {
        natural_scroll = true;
      };

    sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
  };

  general = {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    gaps_in = 5;
    gaps_out = 20;
    border_size = 2;
    layout = "dwindle";

    # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
    allow_tearing = false;
  };

  decoration = {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    rounding = 10;

    blur.enabled = false;
    drop_shadow = false;
  };

  animations =
    {
      enabled = true;

      # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

      animation =
        [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
    };

  dwindle = {
    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
    pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = true; # you probably want this
  };

  master = {
    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
    new_is_master = true;
  };

  gestures = {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more
    workspace_swipe = true;
  };

  misc = {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more
    vfr = true;
    disable_splash_rendering = true;
    disable_hyprland_logo = true;
  };

  # Example windowrule v1
  # windowrule = float, ^(kitty)$
  # Example windowrule v2
  # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
  # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
  windowrulev2 = [
    "suppressevent maximize, class:.* " # You'll probably like this.
  ];


  # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
  bind = [
    "$mainMod, RETURN, exec, $terminal"
    "$mainMod, C, killactive,"

    "$mainMod, Q, exit,"
    "$mainMod, F, togglefloating,"

    "$mainMod, D, exec, $menu"
    "$mainMod, T, togglesplit, " # dwindle

    "$mainMod, ESCAPE, exec, powermenu" # dwindle

    # Move focus with mainMod + arrow keys
    "$mainMod, left, movefocus, l"
    "$mainMod, right, movefocus, r"
    "$mainMod, up, movefocus, u"
    "$mainMod, down, movefocus, d"

    "$mainMod_SHIFT, left, movewindow, l"
    "$mainMod_SHIFT, right, movewindow, r"
    "$mainMod_SHIFT, up, movewindow, u"
    "$mainMod_SHIFT, down, movewindow, d"

    # Switch workspaces with mainMod + [0-9]
    "$mainMod, 1, workspace, 1"
    "$mainMod, 2, workspace, 2"
    "$mainMod, 3, workspace, 3"
    "$mainMod, 4, workspace, 4"
    "$mainMod, 5, workspace, 5"
    "$mainMod, 6, workspace, 6"
    "$mainMod, 7, workspace, 7"
    "$mainMod, 8, workspace, 8"
    "$mainMod, 9, workspace, 9"
    "$mainMod, 0, workspace, 10"

    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    "$mainMod SHIFT, 1, movetoworkspace, 1"
    "$mainMod SHIFT, 2, movetoworkspace, 2"
    "$mainMod SHIFT, 3, movetoworkspace, 3"
    "$mainMod SHIFT, 4, movetoworkspace, 4"
    "$mainMod SHIFT, 5, movetoworkspace, 5"
    "$mainMod SHIFT, 6, movetoworkspace, 6"
    "$mainMod SHIFT, 7, movetoworkspace, 7"
    "$mainMod SHIFT, 8, movetoworkspace, 8"
    "$mainMod SHIFT, 9, movetoworkspace, 9"
    "$mainMod SHIFT, 0, movetoworkspace, 10"

    # Example special workspace (scratchpad)
    "$mainMod, S, togglespecialworkspace, magic"
    "$mainMod SHIFT, S, movetoworkspace, special:magic"
  ];

  bindm = [
    # Move/resize windows with mainMod + LMB/RMB and dragging
    "$mainMod, mouse:272, movewindow"
    "$mainMod_CTRL, mouse:272, resizewindow"
  ];

  # media keys
  bindle = [
    ", XF86AudioRaiseVolume, exec, pamixer --increase 10"
    ", XF86AudioLowerVolume, exec, pamixer --decrease 10"
    ", XF86MonBrightnessUp, exec, brightnessctl set +10%"
    ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
    ", XF86Search, exec, launchpad"

  ];

  bindl = [
    # ", XF86AudioMute, exec, amixer set Master toggle"
    ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ", XF86AudioPlay, exec, playerctl play-pause" # the stupid key is called play , but it toggles
    ", XF86AudioNext, exec, playerctl next"
    ", XF86AudioPrev, exec, playerctl previous"

  ];
}
