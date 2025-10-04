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

  # Audio settings
  # Enable PipeWire for modern audio handling
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable Musnix for real-time audio optimizations (also enables rtkit)
  musnix.enable = true;

  # Set fixed quantum to PipeWire and PulseAudio
  services.pipewire.extraConfig = {
    pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 256;
        "default.clock.min-quantum" = 256;
        "default.clock.max-quantum" = 256;
      };
    };

    pipewire-pulse."92-low-latency" = {
      "context.properties" = [
        {
          name = "libpipewire-module-protocol-pulse";
          args = { };
        }
      ];
      "pulse.properties" = {
        "pulse.min.req" = "256/48000";
        "pulse.default.req" = "256/48000";
        "pulse.max.req" = "256/48000";
        "pulse.min.quantum" = "256/48000";
        "pulse.max.quantum" = "256/48000";
      };
      "stream.properties" = {
        "node.latency" = "256/48000";
        "resample.quality" = 1;
      };
    };
  };
}
