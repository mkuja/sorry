-- vim: ts=4 sw=4 et
return {
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"sainnhe/gruvbox-material",
	"ray-x/lsp_signature.nvim",
	{'akinsho/toggleterm.nvim', version = "*", config = true},

    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'lewis6991/gitsigns.nvim',
    'puremourning/vimspector',
    {
      "amrbashir/nvim-docs-view",
      lazy = false,
      cmd = "DocsViewToggle",
      auto = false,
      opts = {
        position = "right",
        width = 89,
        update_mode = "manual"
      }
    },
    'github/copilot.vim'
    -- 'petertriho/cmp-git',

    -- Snippets for cmp are required.
    -- 'dcampos/nvim-snippy',
    -- 'dcampos/cmp-snippy'
}
