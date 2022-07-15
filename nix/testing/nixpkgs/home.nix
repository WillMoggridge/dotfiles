{ config, pkgs, ... }:

let
  home = builtins.getEnv "HOME";

  defaultPkgs = with pkgs; [
    autorandr
    bat
    # helvum
    i3status-rust
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

}
