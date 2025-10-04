{ config, pkgs, ... }:

{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.consoleMode = "max";

  # Use the latest kernel for better support of recent hardware
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Use ZRAM for swap to improve performance on systems with enough RAM
  zramSwap.enable = true;

  # Set time zone and locale
  time.timeZone = "Europe/Madrid";
  i18n.defaultLocale = "en_GB.UTF-8";

  # Enable PipeWire for modern audio handling
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable Musnix for real-time audio optimizations (also enables rtkit)
  musnix.enable = true;
}
