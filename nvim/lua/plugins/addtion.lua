return {
    ---------------------------------------------------------------------------
    -- MARKDOWN FILE RENDRER 
    ---------------------------------------------------------------------------
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        cmd = { "RenderMarkdown" },
    },

    ---------------------------------------------------------------------------
    -- LEETCODE (LANGUAGE C) 
    ---------------------------------------------------------------------------
    {
        "kawre/leetcode.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            lang = "c",
            storage = {
                home = vim.fn.stdpath("data") .. "/leetcode",
            },
        },
    },
    ---------------------------------------------------------------------------
    -- CURSOR ANIMATION 
    ---------------------------------------------------------------------------

    { "sphamba/smear-cursor.nvim", opts = {} },

    ---------------------------------------------------------------------------
    -- VISUAL MULTI 
    ---------------------------------------------------------------------------
    {
        "mg979/vim-visual-multi",
        branch = "master",
        init = function()
            vim.g.VM_default_mappings = 0
            vim.g.VM_mouse_mappings = 0
        end,
    },
    ---------------------------------------------------------------------------
    -- KEYBIND HELP
    ---------------------------------------------------------------------------
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("config.wk")
        end
    },

    ---------------------------------------------------------------------------
    --  SNACK (MISC ULTILITIES)
    ---------------------------------------------------------------------------

    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        config=function ()
            require("config.snack")
        end
    },

    ---------------------------------------------------------------------------
    -- MONKEY TYPE
    ---------------------------------------------------------------------------
    {
        "kwakzalver/duckytype.nvim",
        opts={
            number_of_words = 10,
            highlight = {
                good = "Comment",
                bad = "Error",
                remaining = "Todo",
            },
        },
    },
}
