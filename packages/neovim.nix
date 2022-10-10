{ neovim, vimPlugins, tree-sitter }:

neovim.override {
  vimAlias = true;
  viAlais = true;
  configure = {
    customRC = ''
      luafile ${../config/nvim/init.lua}
    '';
    packages.myVimPackage = with vimPlugins; {
      start = [
        LanguageClient-neovim
        vim-nix
        telescope-nvim
        plenary-nvim
        popup-nvim
        nvim-lspconfig
        nvim-cmp
        cmp-nvim-lsp
        gitsigns-nvim
        kanagaway-nvim
        which-key-nvim
        (nvim-treesitter.withPlugins (plugins: tree-sitter.allGrammars))
      ];
    };
  };
}
