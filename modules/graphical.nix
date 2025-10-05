{ pkgs, ... }:

{
  # AMD GPU drivers
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # KDE Plasma Desktop Environment
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Set environment variables for Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Install fonts
  fonts.packages = with pkgs; [
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    tlwg # Thai fonts
  ];
}
