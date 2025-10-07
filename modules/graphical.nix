{ pkgs, ... }:

{
  # AMD GPU drivers
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Enable GNOME Desktop Environment
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Set environment variables for Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Configure Qt applications to integrate with GNOME
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # Install fonts
  fonts.packages = with pkgs; [
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    tlwg # Thai fonts
  ];
}
