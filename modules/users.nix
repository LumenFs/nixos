{ ... }:

{
  users.users = {
    lumenfs = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "audio" ]; # Sudo, network, and audio permissions
    };
    olga = {
      isNormalUser = true;
    };
  };
}
