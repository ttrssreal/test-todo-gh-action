{ inputs
, ...
}: {
  imports = with inputs; [
    nixvim.homeManagerModules.nixvim
    ./plugins
    ./keymaps.nix
    ./options.nix
    ./lsp.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    colorschemes.tokyonight.enable = true;

    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };
  };
}
