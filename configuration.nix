# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let 
    unstable = import <nixos-unstable> {config = { allowUnfree = true; }; };

in 
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
 
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.timeout = 15;
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub ={ 
    enable = true;
    efiSupport = true;
    device = "nodev";
    extraEntries = ''
      menuentry "Windows" {
        insmod vfat
	insmod part_gpt
	insmod chain
	search --no-floppy --fs-uuid  7C06-AAD2 --set root
	chainloader /EFI/Microsoft/Boot/bootmgfw.efi
      }
      '';
  };

  time.hardwareClockInLocalTime = true;


  # vm
  virtualisation.docker.enable = true; 
  networking.hostName = "n1x0s"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.networkmanager.enable = true;
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8" "zh_CN.UTF-8/UTF-8" "zh_TW.UTF-8/UTF-8" "ko_KR.UTF-8/UTF-8" "ja_JP.UTF-8/UTF-8" ];
  };
  console = {
  font = "Lat2-Terminus16";
  keyMap = "us";
  };
  i18n.inputMethod = {
    #enabled = "fcitx";
    #fcitx.engines = with pkgs.fcitx-engines;
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines;
    [ mozc hangul rime ];
  };
 
  # fonts
  fonts.fonts = with pkgs; [
    emojione
    fira-mono
    hack-font
    terminus_font
    ubuntu_font_family
    fira-code
    source-code-pro
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    fira-code-symbols
    dina-font
    proggyfonts
    roboto-mono
    iosevka
    jetbrains-mono
    cascadia-code
  ]; 
  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the Plasma 5 Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # bspwm
  services.xserver.windowManager.bspwm.enable = true;
  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sn0w = {
  isNormalUser = true;
  home = "/home/sn0w/";
  extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
  shell = pkgs.zsh;
  };
   
  #users.users.chance = {
  #isNormalUser = true;
  #extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #};

  # Nvidia drivers are unfree
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
      environment.systemPackages = with pkgs; [
  # theme
  nordic
  # editor
  neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #emacs
  unstable.emacs
  vscode
  # terminal
  kitty
  # utilities
  wget
  curl
  git
  zsh
  tmux
  screen
  unzip
  unrar
  polybar
  rofi
  ranger
  gnome-breeze
  gnome.gnome-tweaks
  feh
  xclip
  htop
  # web browser
  firefox
  google-chrome
  # dev
  clang_13
  gcc11
  gdb
  cmake
  python310
  jdk
  chez
  python39Packages.ipython
  python39Packages.pip
  python-language-server
  nodejs
  rustup
  scala
  sbt
  ghc
  #go
  #unstable.go
  unstable.go_1_18
  R
  rstudio
  android-studio
  jetbrains.pycharm-community
  jetbrains.idea-community
  # lsp
  rust-analyzer
  gopls
  # vm
  docker
  qemu 
  # net
  openssl
  openvpn
  vagrant
  # etc
  pinta
  ffmpeg
  mpv
  discord
  zathura
  unstable.notion-app-enhanced
  ];
  
 # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.zsh.enable = true;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.autosuggestions.enable = true;
  programs.zsh.ohMyZsh = {
    enable = true;
    plugins = [ "git" "man" ];
    theme = "lambda";
  };


  # List services that you want to enable:
  
  # Auto upgrade
  system.autoUpgrade.enable = true;

  nix = {
  autoOptimiseStore = true;
  # Automatically trigger garbage collection
  gc.automatic = true;
  gc.dates = "weekly";
  gc.options = "--delete-older-than 30d";
  };
  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

  

}
