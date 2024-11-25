{
  programs.nixvim.plugins.nvim-tree = {
    enable = true;
    autoReloadOnWrite = true;
    openOnSetup = true;
    disableNetrw = true;
    git.enable = true;
    sortBy = "case_sensitive";
  };
}
