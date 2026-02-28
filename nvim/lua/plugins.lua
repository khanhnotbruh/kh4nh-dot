return {
  -- Note: mini.nvim is installed so pls do not install it again
  {
    source="neovim/nvim-lspconfig",
    depends={
      "williamboman/mason.nvim",
    }
  },
  {
    source="kawre/leetcode.nvim",
    depends={
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
  },
  {source="BurntSushi/ripgrep"},
  {
    source="MeanderingProgrammer/render-markdown.nvim",
  },
  {
    source='nvim-treesitter/nvim-treesitter',
    checkout = 'master',
    monitor = 'main',
  },
}
