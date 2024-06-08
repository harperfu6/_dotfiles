return {
  -- gruvbox
  { "ellisonleao/gruvbox.nvim", lazy = true },

  -- vim-code-dark
  { "tomasiser/vim-code-dark", lazy = true, priority = 1000 },

  -- kanagawa
  { "rebelot/kanagawa.nvim", lazy = true },

  -- nvim
  { "catppuccin/nvim", name = "catppuccin", lazy = true },

  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "gruvbox",
      colorscheme = "codedark",
      -- colorscheme = "kanagawa-wave",
      -- colorscheme = "catppuccin",
    },
  },
}
