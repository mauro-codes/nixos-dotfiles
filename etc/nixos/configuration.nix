# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Argentina/Buenos_Aires";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_AR.utf8";
    LC_IDENTIFICATION = "es_AR.utf8";
    LC_MEASUREMENT = "es_AR.utf8";
    LC_MONETARY = "es_AR.utf8";
    LC_NAME = "es_AR.utf8";
    LC_NUMERIC = "es_AR.utf8";
    LC_PAPER = "es_AR.utf8";
    LC_TELEPHONE = "es_AR.utf8";
    LC_TIME = "es_AR.utf8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mauro = {
    isNormalUser = true;
    description = "Mauro";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };
  
  home-manager.useGlobalPkgs = true;
  home-manager.users.mauro = { pkgs, ... }: {
    
    home.packages = with pkgs; [
      
    ];

    programs.bash.enable = true;

    # Picom configuration
    # ------------------------------------------------------
    # ------------------------------------------------------

    services.picom = {
      enable = true;
      experimentalBackends = true;
      inactiveOpacity = "0.9";
      vSync = true;
    };
    
    # Rofi configuration
    # ------------------------------------------------------
    # ------------------------------------------------------
    
    programs.rofi.enable = true;
    
    # Adding a reference to my custom scripts
    home.file.".config/rofi/my-scripts" = {
      source = /home/mauro/.config/programs/rofi/my-scripts;
      executable = true;
    };

    programs.rofi.extraConfig = {
      modi = "drun,run,custom:~/.config/programs/rofi/my-scripts";
      lines = 5;
      font = "JetBrainsMono Nerd Font 14";
      show-icons = true;
      icon-theme = "Oranchelo";
      terminal = "st";
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-window = " 﩯  window";
      display-Network = " 󰤨  Network";
      sidebar-mode = true; 
    };

    # Theme configuration
    programs.rofi.theme = /home/mauro/.config/programs/rofi/theme.rasi; 

    

    # Polybar configuration
    # ------------------------------------------------------
    # ------------------------------------------------------

    services.polybar = {
      enable = true;
      script = "/home/mauro/.config/programs/polybar/./launch.sh";
      config = /home/mauro/.config/programs/polybar/config.ini;
    };

    gtk.theme.name = "Adwaita-Dark";
   
    programs.alacritty = {
      enable = true;
    };

  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = ["electron-12.2.3"];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    spicetify-cli
    feh
    dunst
    vscode
    discord
    spotify
    teams
    brave
    thunderbird
    filezilla
    remmina
    etcher
    peek
    flameshot
    obs-studio
    ranger
    screenkey
    zoom-us
    vlc
    mpv
    nodejs
    android-tools
    azuredatastudio
    unzip
    sxhkd
    pfetch
  ];

  system.stateVersion = "22.05"; # Did you read the comment?
  
  # Customizations
  services.xserver.displayManager.lightdm.greeters.gtk.theme.name = "Adwaita-Dark";
  programs.neovim.enable = true;
  programs.chromium.enable = true;
  programs.git.enable = true;
  services.xserver.windowManager.bspwm.enable = true; 
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  xdg.portal.enable = true;
  services.spotifyd.enable = true;
  services.flatpak.enable = true;
  services.deluge.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  virtualisation.docker.enable = true;
  programs.bash.interactiveShellInit = "pfetch"; 

  # Fonts
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}
