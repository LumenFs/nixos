{ pkgs, inputs, ... }:

let
  # Define a custom Discord package with OpenASAR and Moonlight
  custom-discord = pkgs.discord.override {
    withOpenASAR = true;
    withMoonlight = true;
    moonlight = inputs.moonlight.packages.${pkgs.system}.moonlight;
  };
  # Remove bottles popup
  custom-bottles = pkgs.bottles.override {
    removeWarningPopup = true;
  };
in
{
  # List all system-wide packages here
  environment.systemPackages = with pkgs; [
    # --- GNOME & GUI Apps ---
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnome-builder   # IDE for GNOME
    refine          # Extra GNOME settings
    chromium        # Web browser
    prismlauncher   # Minecraft launcher
    easyeffects     # Audio equalizer
    obs-studio      # Screen recording
    fragments       # Torrent client
    resources       # System monitor GUI
    custom-discord  # Custom Discord build
    custom-bottles  # Custom Bottles build

    # --- TUI & CLI Tools ---
    fastfetch # System information fetcher
    btop      # Resource monitor
    wget      # Network downloader
    git       # Version control

    # --- Utilities & Theming ---
    p7zip          # 7-Zip archive support
    unrar          # RAR archive support
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
