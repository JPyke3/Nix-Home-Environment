{pkgs, ...}: {
  home.packages = [
    pkgs.steam
    pkgs.legcord
  ];

  imports = [
    ../home.nix
    ../../../programs/desktop/firefox.nix
  ];

  home.stateVersion = "24.05"; # Please read the comment before changing.
}
