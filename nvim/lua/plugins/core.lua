return{
    ---------------------------------------------------------------------------
    -- TREE SITTER 
    ---------------------------------------------------------------------------
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("config.treesitter")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "master",
        requires = "nvim-treesitter/nvim-treesitter",
    },
    {
        "nvim-treesitter/playground",
        branch = "master",
        requires = "nvim-treesitter/nvim-treesitter",
    },

    ---------------------------------------------------------------------------
    --NEO TREE (FILE EXPLORER) + UNDO TREE  
    ---------------------------------------------------------------------------
    {
        "nvim-tree/nvim-web-devicons",
        build = function()
            -- download patched font if missing
            local fira = vim.fn.expand("~/.local/share/fonts/FiraCode Nerd Font Complete.ttf")
            if vim.fn.filereadable(fira) == 0 then
                vim.fn.system({
                    "curl", "-fLo",
                    vim.fn.expand("~/.local/share/fonts/FiraCode.zip"),
                    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip",
                })
                vim.fn.system({
                    "unzip", "-o",
                    vim.fn.expand("~/.local/share/fonts/FiraCode.zip"),
                    "-d", vim.fn.expand("~/.local/share/fonts/")
                })
                print("Installed FiraCode Nerd Font")
            end
        end,
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("config.neotree")
        end,
    },
    {"mbbill/undotree",cmd = "UndotreeToggle"},


    ---------------------------------------------------------------------------
    -- LSP + MASON
    ---------------------------------------------------------------------------
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("config.lsp")
        end,
    },

    ---------------------------------------------------------------------------
    -- CMP
    ---------------------------------------------------------------------------
     {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "f3fora/cmp-spell",
        },
        config = function()
            require("config.cmp")
        end,
    },
    -----------------------------------------------------------------------------
    -- UI
    -----------------------------------------------------------------------------
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = require("config.noice")
    },

    ---------------------------------------------------------------------------
    -- NAVIGATION 
    ---------------------------------------------------------------------------
    {
        'nvim-telescope/telescope.nvim',
        tag = 'v0.2.0',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require("config.telescope")
        end
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { "nvim-lua/plenary.nvim" },
    },

    ---------------------------------------------------------------------------
    -- EDITING 
    ---------------------------------------------------------------------------
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({
                check_ts = true,  -- enable treesitter integration
                fast_wrap = {},   -- optional: allows you to wrap existing text with brackets
            })
        end
    },

    {
        "kylechui/nvim-surround",
        version = "*",
        config = function()
            require("config.surround")
        end
    },
}
