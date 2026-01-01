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
    }
}
