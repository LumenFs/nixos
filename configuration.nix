{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/system.nix
    ./modules/graphical.nix
    ./modules/packages.nix
    ./modules/users.nix
  ];

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.nixPath = [ "/home/lumenfs/nixos" ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.rocmSupport = true; # For AMD GPU compute
  programs.nix-ld.enable = true;

  # Networking
  networking.hostName = "nixos"; # Set your hostname
  networking.networkmanager.enable = true;
  services.resolved.enable = true;
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
