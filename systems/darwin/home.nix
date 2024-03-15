{
  config,
  pkgs,
  inputs,
  ...
}: let
  nix-colors = import <nix-colors> {};
in {
  home.username = "jacobpyke";
  home.homeDirectory = "/Users/jacobpyke";

  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    rectangle
    darwin.apple_sdk.frameworks.Foundation
  ];

  nixpkgs.overlays = [
    inputs.nixpkgs-firefox-darwin.overlay
  ];

  imports = [
    ../../programs/desktop/alacritty.nix
    ../../programs/desktop/firefox.nix
    ../../programs/desktop/kitty/kitty.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
