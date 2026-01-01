return{
    {
        "kawre/leetcode.nvim",
        build = ":TSInstall html",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            lang = "c",
        },
    },
    { "folke/twilight.nvim", cmd = "Twilight" },
    {"sphamba/smear-cursor.nvim",opts={}},
    {
        "mg979/vim-visual-multi",
        branch="master",
    },
    {
        "NeogitOrg/neogit",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration
            "folke/snacks.nvim",             -- optional
        },
        cmd = "Neogit",
    },
}
