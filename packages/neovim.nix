{ pkgs, neovim, vimPlugins, tree-sitter }:

neovim.override {
  vimAlias = true;
  viAlias = true;
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
        kanagawa-nvim
        which-key-nvim
        (nvim-treesitter.withPlugins (plugins: tree-sitter.allGrammars))
      ];
    };
  };
}

# This was egregiously copied from github:Hoverbear-Consulting/flake
# Also see https://hoverbear.org/blog/configurable-nix-packages/
