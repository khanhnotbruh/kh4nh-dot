local cmp = require("cmp")
local luasnip = require("luasnip")
local keymap = require("keymap")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    mapping = cmp.mapping.preset.insert(
        keymap.cmp(cmp, luasnip)
    ),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer" },
    }),

    completion = {
        completeopt = "menu,menuone,noselect",
        autocomplete = { cmp.TriggerEvent.TextChanged },
    },
})
