require("noice").setup({
    views = {
        cmdline_popup = {
            position = {
                row = 5,
                col = "50%",
            },
            size = {
                width = 60,
                height = "auto",
            },
        },
        popupmenu = {
            relative = "editor",
            position = {
                row = "40%",
                col = "50%",
            },
            size = {
                width = 30,
                height = 10,
            },
            border = {
                style = "rounded",
                padding = { 0, 1 },
            },
            win_options = {
                winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
            },
        },
        errlog_popup = {
            ui = 'float',
            opts = {
                row = 5,
                col = '50%',
                min_width = 50,
                max_width = 80,
                max_height = 10,
                zindex = 99,
                border = { style = 'single' },
            },
            position = 'center',
        },
        routes = {
            -- This block connects the message (filter) to the window (view)
            {
                view = 'errlog_popup',
                filter = {
                    event = 'notify',
                    kind = 'notify',
                    find = 'KHANH_NOICE_', -- <--- THIS IS YOUR TRIGGER
                },
            },
        },
    },
})
