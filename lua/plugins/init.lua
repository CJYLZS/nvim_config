local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    require("plugins.ui.tokyonight"),
    require("plugins.ui.alpha"),
    require("plugins.ui.bufferline"),
    require("plugins.ui.gitsigns"),
    require("plugins.ui.lualine"),
    require("plugins.ui.neo-tree"),
    require("plugins.ui.toggleterm"),
    require("plugins.ui.noice"),
    require("plugins.ui.windows"),
    require("plugins.code.comment"),
    require("plugins.code.indent-blankline"),
    require("plugins.code.leap"),
    require("plugins.code.luasnip"),
    require("plugins.code.nvim-autopairs"),
    require("plugins.code.nvim-cmp"),
    require("plugins.code.nvim-cursorline"),
    require("plugins.code.nvim-surround"),
    require("plugins.code.nvim-treesitter"),
    require("plugins.code.treesitter-playground"),
    require("plugins.lsp.lsp_signature"),
    require("plugins.lsp.nvim-lspconfig"),
    require("plugins.utils.auto-session"),
    require("plugins.utils.bufremove"),
    require("plugins.utils.startuptime"),
    require("plugins.utils.telescope"),
    require("plugins.utils.which-key"),
    require("plugins.utils.nvim-osc52"),
    require("plugins.utils.nvim-bufsurf"),
    require("plugins.utils.nvim-spectre"),
    require("plugins.code.copilot"),
    require("plugins.code.copilot-cmp"),
}
local opts = {}
require("lazy").setup({ plugins, opts })

-- extra formatter
require("plugins.code.formatter")
