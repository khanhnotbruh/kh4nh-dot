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
        { name = "nvim_lsp" }, -- LSP completions
        { name = "luasnip" },  -- snippets
        { name = "buffer" },   -- words in buffer
        { name = "path" },     -- filesystem paths
    }),

    completion = {
        completeopt = "menu,menuone,noselect",
        autocomplete = { cmp.TriggerEvent.TextChanged },
    },
})
cmp.setup.filetype({ "markdown", "text" }, {
    sources = cmp.config.sources({
        { name = "spell"},
        { name = "buffer"},
        { name = "path" },
    }),
})
