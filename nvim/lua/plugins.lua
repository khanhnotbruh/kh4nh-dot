local plugins= {
  -- Note: mini.nvim is installed so pls do not install it again
  --{
  --   source="neovim/nvim-lspconfig",
  --   depends={
  --     "williamboman/mason.nvim",
  --   }
  -- },
  {source="BurntSushi/ripgrep"},
  { source="sphamba/smear-cursor.nvim"},
  {source="MeanderingProgrammer/render-markdown.nvim"},
  {
    source='mg979/vim-visual-multi',
    branch ='master',
  },
  {
    source="Thiago4532/mdmath.nvim",
    hooks={post_checkout=function()
      vim.cmd('MdMath build')
    end}
  },
  {
    source="iamcco/markdown-preview.nvim",
    hooks={post_checkout=function()
      vim.fn["mkdp#util#install"]()
    end}
  }
}
if vim.fn.executable("gcc")==1
  or vim.fn.executable("clang")==1 then
     table.insert(plugins,{
       source='nvim-treesitter/nvim-treesitter',
       checkout = 'main',
       hooks = { post_checkout = function()
         vim.cmd('TSUpdate')
       end }
     })
     table.insert(plugins,{
       source='nvim-treesitter/nvim-treesitter-textobjects',
       checkout='main',
       depends={
         'nvim-treesitter/nvim-treesitter'
       },
       hooks = { post_checkout = function()
         vim.cmd('TSUpdate')
       end }
     })
 end

return plugins
