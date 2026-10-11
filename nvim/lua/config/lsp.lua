local capabilities=vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport=true

local native_lsp_group=vim.api.nvim_create_augroup("NativeLspConfig",{clear=true})

-- Improved: Returns nil if no marker is found,letting vim.lsp.start handle single-file fallbacks
local function get_root_dir(markers)
  local found=vim.fs.find(markers,{upward=true})[1]
  if found then
    return vim.fs.dirname(found)
  end
  return nil
end

vim.highlight.priorities.semantic_tokens = 95
-- Only disable LSP semantic tokens if Treesitter is actively highlighting this buffer
local function common_on_attach(client, bufnr)
  -- if bufnr and vim.treesitter.highlighter.active[bufnr] then
  --   client.server_capabilities.semanticTokensProvider = nil
  -- end
end

local servers={
  cmake={
    name="cmake-language-server",
    exec={"cmake-language-server"},
  },
  qml={
    name="qml-language-server",
    exec={"qml-language-server"},
  },
  lua={
    name="lua_ls",
    exec={"lua-language-server"},
    root_markers={".git","init.lua"},
    settings={
      Lua={
        diagnostics={globals={"vim"}},
      },
    },
  },
  clangd={
    name="clangd",
    pattern={"c","cpp","objc","objcpp"},
    exec={"clangd"},
    flag={"--background-index","-j=2","--pch-storage=disk"},
    root_markers={".git","compile_commands.json","CMakeLists.txt"},
  },
  python={
    name="pyright",
    exec={"pyright-langserver"},
    flag={"--standardio"},
    root_markers={".git","setup.py","pyproject.toml","requirements.txt"},
    settings={
      python={
        analysis={typeCheckingMode="basic"},
      },
    },
  },
}

for ft,config in pairs(servers)do
  vim.api.nvim_create_autocmd("FileType",{
    group=config.group or native_lsp_group,
    pattern=config.pattern or ft,
    callback=function()
      local exe=type(config.exec)=="table" and config.exec[1] or config.exec
      if exe and vim.fn.executable(exe)~=1 then return end

      local cmd=type(config.exec)=="table" and vim.list_extend({},config.exec)or{config.exec}
      if config.flag then
        if type(config.flag)=="table" then
          vim.list_extend(cmd,config.flag)
        else
          table.insert(cmd,config.flag)
        end
      end

      vim.lsp.start({
        name=config.name,
        cmd=cmd,
        root_dir=(config.root_markers and get_root_dir(config.root_markers))or config.root_dir or get_root_dir({".git","CMakeLists.txt"})or vim.fn.expand("%:p:h"),
        capabilities=config.capabilities or capabilities,
        on_attach=config.on_attach or common_on_attach,
        settings=config.settings,
      })
    end,
  })
end

-- 5. Global LSP Attach Options
vim.api.nvim_create_autocmd('LspAttach',{
  group=native_lsp_group,-- Added to the group so it flushes cleanly on reload
  callback=function(args)
    vim.bo[args.buf].omnifunc='v:lua.vim.lsp.omnifunc'
  end,
})
