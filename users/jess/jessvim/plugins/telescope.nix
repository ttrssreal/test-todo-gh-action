{ pkgs
, ...
}: {
  programs.nixvim.plugins.telescope = {
    enable = true;
    settings.defaults.mappings.i = {
      "<C-j>".__raw = "require('telescope.actions').move_selection_next";
      "<C-k>".__raw = "require('telescope.actions').move_selection_previous";
    };
  };

  # for live_grep
  home.packages = [ pkgs.ripgrep ];
}
