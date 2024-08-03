-- vim: ts=4 sw=4 et
--
vim.g.mapleader = ","
vim.g.maplocalleader = ","

require("config.lazy")
require("mason").setup()
require("mason-lspconfig").setup()


-- Set up nvim-cmp.
local cmp = require 'cmp'

vim.cmd(":nnoremap <leader>doc :DocsViewToggle<cr>")
vim.cmd(":nnoremap <leader>docu :DocsViewUpdate<cr>")

-- Vimspector mappings
vim.cmd(":nnoremap <leader>stop <Plug>VimspectorStop")
vim.cmd(":nnoremap <leader>lsbreak <Plug>VimspectorBreakpoints")
vim.cmd(":nnoremap <F2> <Plug>VimspectorToggleBreakpoint")
vim.cmd(":nnoremap <F3> <Plug>VimspectorToggleConditionalBreakpoint")
vim.cmd(":nnoremap <F5> <Plug>VimspectorGoToCurrentLine")
vim.cmd(":nnoremap <F6> <Plug>VimspectorBalloonEval")
vim.cmd(":nnoremap <F7> <Plug>VimspectorRestart")
vim.cmd(":nnoremap <F8> <Plug>VimspectorContinue")
vim.cmd(":nnoremap <F9> <Plug>VimspectorStepInto")
vim.cmd(":nnoremap <F10> <Plug>VimspectorStepOver")
vim.cmd(":nnoremap <F11> <Plug>VimspectorStepOut")
vim.cmd(":nnoremap <F12> <Plug>VimspectorRunToCursor")
vim.cmd(":nnoremap <leader>fsu <Plug>VimspectorUpFrame")
vim.cmd(":nnoremap <leader>fsd <Plug>VimspectorDownFrame")
vim.cmd(":nnoremap <leader>jmpn <Plug>VimspectorJumpToNextBreakPoint")
vim.cmd(":nnoremap <leader>jmpp <Plug>VimspectorJumpToPreviousBreakPoint")



vim.cmd(":set scrolloff=5")
vim.cmd(":set cc=89")


cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
--        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'buffer' },
    })
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
-- require("cmp_git").setup()
-- cmp.setup.filetype('gitcommit', {
--     sources = cmp.config.sources({
--       { name = 'git' },
--     }, {
--       { name = 'buffer' },
--     })
--  })

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
local cmp_nvim_lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--     capabilities = cmp_nvim_lsp_capabilities
-- }
-- After setting up mason-lspconfig you may set up servers via lspconfig
require("lspconfig").lua_ls.setup {}
require("lspconfig").rust_analyzer.setup {}
require("lspconfig").basedpyright.setup {
    capabilities = cmp_nvim_lsp_capabilities
}
require("toggleterm").setup {
    hide_numbers = true,
}
require('gitsigns').setup {
    on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end)

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end)

    
    -- Actions
    map('n', '<leader>hs', gitsigns.stage_hunk)
    map('n', '<leader>hr', gitsigns.reset_hunk)
    map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('n', '<leader>hS', gitsigns.stage_buffer)
    map('n', '<leader>hu', gitsigns.undo_stage_hunk)
    map('n', '<leader>hR', gitsigns.reset_buffer)
    map('n', '<leader>hp', gitsigns.preview_hunk)
    map('n', '<leader>gb', function() gitsigns.blame_line{full=true} end)
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
    map('n', '<leader>hd', gitsigns.diffthis)
    map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
    map('n', '<leader>td', gitsigns.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}


-- " set
vim.cmd.autocmd 'TermEnter term://*toggleterm#* tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>'

-- " By applying the mappings this way you can pass a count to your
-- " mapping to open a specific window.
-- " For example: 2<C-t> will open terminal 2
vim.cmd.nnoremap '<silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>'
vim.cmd.inoremap '<silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>'

vim.cmd.colorscheme "gruvbox-material"
vim.cmd.set "number"
vim.cmd.imap "<C-Space> <C-x><C-o>"
vim.cmd.inoremap "{ {}<Esc>i"


local lspconfig = require("lspconfig")

lspconfig["lua_ls"].setup({})
lspconfig["rust_analyzer"].setup({
    settings = {
        ["rust-analyzer"] = {
            diagnostics = {
                disabled = { "inactive-code" },
            }
        },
    },
})
lspconfig["basedpyright"].setup({
    settings = {
        ["basedpyright"] = {
            analysis = {
                -- autoSearchPaths = true,
                -- diagnosticMode = "openFilesOnly",
                -- useLibraryCodeForTypes = true,
                reportUnknownLambdaType = false,
            },
        },
    }
})
lspconfig["clangd"].setup({})

-- lsp_signature UI tweaks
require("lsp_signature").setup({
    bind = true,
    handler_opts = {
        border = "rounded",
    },
})

-- LSP hover window UI tweaks
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = "single"
    }
)

-- LSP diagnostics
vim.diagnostic.config {
    float = { border = "single" },
    underline = true,
    virtual_text = true,
    virtual_lines = true
}

-- Key bindings to be set after LSP attaches to buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        vim.api.nvim_buf_set_option(ev.buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
        vim.api.nvim_buf_set_option(ev.buf, "formatexpr", "v:lua.vim.lsp.formatexpr()")

        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts) SEE telescope.lua
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    end,
})


-- For Cargo.toml
local function show_documentation()
    local filetype = vim.bo.filetype
    if filetype == "vim" or filetype == "help" then
        vim.cmd('h '..vim.fn.expand('<cword>'))
    elseif filetype == "man" then
        vim.cmd('Man '..vim.fn.expand('<cword>'))
    elseif vim.fn.expand('%:t') == 'Cargo.toml' and require('crates').popup_available() then
        require('crates').show_popup()
    else
        vim.lsp.buf.hover()
    end
end
vim.keymap.set('n', 'K', show_documentation, { silent = true })

