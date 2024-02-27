{
  config,
  pkgs,
  ...
}: let
  fontSize =
    if pkgs.stdenv.isDarwin
    then 14
    else 8.5;
in {
  home.packages = with pkgs; [
	  (nerdfonts.override { fonts = [ "Mononoki" ]; })
  ];
  programs.alacritty = {
    enable = true;
    settings = {
      font.size = fontSize;
	  font.family = "Mononoki Nerd Font";
      env.TERM = "xterm-256color";
      colors = with config.colorScheme.colors; {
        bright = {
          black = "0x${base00}";
          blue = "0x${base0D}";
          cyan = "0x${base0C}";
          green = "0x${base0B}";
          magenta = "0x${base0E}";
          red = "0x${base08}";
          white = "0x${base06}";
          yellow = "0x${base09}";
        };
        cursor = {
          cursor = "0x${base06}";
          text = "0x${base06}";
        };
        normal = {
          black = "0x${base00}";
          blue = "0x${base0D}";
          cyan = "0x${base0C}";
          green = "0x${base0B}";
          magenta = "0x${base0E}";
          red = "0x${base08}";
          white = "0x${base06}";
          yellow = "0x${base0A}";
        };
        primary = {
          background = "0x${base00}";
          foreground = "0x${base06}";
        };
      };
    };
  };
}
