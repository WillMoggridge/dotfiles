{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "my-packages";
      paths = [
        pipewire
        wireplumber
      ];
    };
  };
}


let
  pkgs = import <nixpkgs> {};
  inherit (pkgs) curl jq;
in

{

  # hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;

    media-session.enable = false;
    services.pipewire.wireplumber.enable = true;

    # config.pipewire = {
    #   "context.properties" = {
    #     #"link.max-buffers" = 64;
    #     "link.max-buffers" = 16; # version < 3 clients can't handle more than this
    #     "log.level" = 2; # https://docs.pipewire.org/page_daemon.html
    #     #"default.clock.rate" = 48000;
    #     #"default.clock.quantum" = 1024;
    #     #"default.clock.min-quantum" = 32;
    #     #"default.clock.max-quantum" = 8192;
    # };
  };
}
