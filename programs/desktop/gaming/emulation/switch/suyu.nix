{
  inputs,
  config,
  system,
  ...
}: let
  pkgs = import inputs.unstable {inherit system;};
  nur-no-pkgs = import inputs.nur {
    nurpkgs = import inputs.nixpkgis {system = "x86_64-linux";};
    pkgs = pkgs;
  };
in {
  imports = [
    ./secrets/prodkeys.nix
  ];

  home.packages = [
    nur-no-pkgs.repos.jpyke3.suyu-dev
  ];

  home.file."${config.home.homeDirectory}/.local/share/suyu/keys/prod.keys".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.local/emulation/keys/prod.keys";

  home.file."${config.home.homeDirectory}/.local/share/suyu/nand/user/save".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/data/Games/Saves/Yuzu/save";

  home.file."${config.home.homeDirectory}/.local/share/suyu/load".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/data/Games/Mods/Yuzu";
}
