{ pkgs, config, ... }:
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home.packages = with pkgs; [
    # LSP servers
    lua-language-server
    nil # Nix LSP
    nodePackages.typescript-language-server
    pyright
    gopls
    clang-tools
    
    # Formatters/Linters
    stylua
    black
    eslint
    prettier
    nixpkgs-fmt
    
    # Tools
    ripgrep # for telescope
    fd
    fzf
  ];

  # Copy neovim config directory to ~/.config/nvim
  xdg.configFile."nvim" = {
    source = ../../../nvim;
    recursive = true;
  };
}
