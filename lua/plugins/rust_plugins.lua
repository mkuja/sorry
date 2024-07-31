-- vim: ts=4 sw=4 et
return {
    {
        'saecki/crates.nvim',
        event = { "BufRead Cargo.toml" },
        tag = 'stable',
        config = function()
            require('crates').setup({
                lsp = {
                    enabled = true,
                    on_attach = function (client, bufnr)
                    end,
                    actions = true,
                    completion = true,
                    hover = true,
                }
            })
        end,
    }
}
