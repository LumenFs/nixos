{ pkgs, ... }:

let
  # Apply the OpenASAR and Vencord patches to Discord
  custom-discord = pkgs.discord.override {
    withOpenASAR = true;
    withVencord = true;
  };
  
  # Remove bottles popup
  custom-bottles = pkgs.bottles.override {
    removeWarningPopup = true;
  };
in
{
  # List all system-wide packages here
  environment.systemPackages = with pkgs; [
    # --- GUI Apps ---
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnome-builder   # IDE for GNOME
    refine          # Extra GNOME settings
    chromium        # Web browser
    prismlauncher   # Minecraft launcher
    easyeffects     # Audio equalizer
    obs-studio      # Screen recording
    haruna          # Video player
    fragments       # Torrent client
    resources       # System monitor GUI
    custom-discord  # Custom Discord build
    custom-bottles  # Custom Bottles build

    # --- CLI Tools ---
    fastfetch # System information fetcher
    btop      # Resource monitor
    wget      # Network downloader
    git       # Version control

    # --- Utilities ---
    p7zip     # 7-Zip archive support
    unrar     # RAR archive support
  ];

  # Steam configuration
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
    # Override to fix a common cursor issue
    package = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [ adwaita-icon-theme ];
    };
  };
}
