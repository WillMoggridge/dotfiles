{ config, pkgs, ... }:

let
  home = builtins.getEnv "HOME";

  defaultPkgs = with pkgs; [
    autorandr
    bat
    # helvum
    flameshot
    i3status-rust
    nwg-panel
    # sway
    # swaylock
    # swayidle
    wl-clipboard
    wofi
    # ytmdesktop

    # Dev
    helix
    k6
  ];

in

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "will";
  home.homeDirectory = "/home/will";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  home.sessionVariables = {
    DISPLAY = ":0";
    EDITOR = "kak";
  };

  home.packages = defaultPkgs;

  xdg.enable = true;

  # restart services on change
  # systemd.user.startServices = "sd-switch";

  # notifications about home-manager news
  news.display = "silent";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # programs.i3status-rust.enable = true;

  services.dunst.enable = true;
  services.dunst.configFile = "$XDG_CONFIG_HOME/dunst.dotfiles/dunstrc";

  # systemd.user.services.sway = {
  #   Unit = {
  #     Description = "sway - i3-compatible Wayland compositor";
  #     Documentation = "man:sway(5)";
  #     # Before = "graphical-session.service";
  #     # BindsTo = "graphical-session.service";
  #     # Wants = "graphical-session-pre.service";
  #     # After = "graphical-session-pre.service";
  #   };

  #   Service = {
  #     Type = "simple";
  #     EnvironmentFile = "-%h/.config/sway/env";
  #     ExecStart = "/usr/bin/sway";
  #     Restart = "on-failure";
  #     RestartSec = "1";
  #     TimeoutStopSec = "10z";
  #   };
  # };

  systemd.user.targets.sway-session = {
    Unit = {
      Description = "sway - i3-compatible Wayland compositor";
      Documentation = "man:systemd.special";
      BindsTo = "graphical-session.target";
      Wants = "graphical-session-pre.target";
      After = "graphical-session-pre.target";
    };
  };

  systemd.user.services.swayidle = {
    Unit = {
      Description = "swayidle - Idle manager for Wayland";
      Documentation = "man:swayidle(1)";
      PartOf = "graphical-session.target";
    };

    Service = {
      Type = "simple";
      ExecStart = "/usr/bin/swayidle -w";
      Restart = "on-failure";
      RestartSec = "1";
    };

    Install = {
      WantedBy = ["sway-session.target"];
    };
  };

}
