-- set Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- remap : -> \
vim.cmd("nnoremap \\ :")

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Better window resizing
vim.api.nvim_set_keymap("n", "<C-Up>", ":resize +2<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-Down>", ":resize -2<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true })

vim.keymap.set("n", "<leader>q", "<Cmd>qa<CR>")
vim.keymap.set("n", "<leader>Q", "<Cmd>qa!<CR>")
vim.keymap.set("n", "<C-s>", "<Cmd>w<CR>")
vim.keymap.set("i", "<C-s>", "<Cmd>w<CR>")

-- lsp
vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", { silent = true })
vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { silent = true })
--       { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
--       { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
--       { "gI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, desc = "Goto Implementation" },
--       { "gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, desc = "Goto T[y]pe Definition" },
--       { "K", vim.lsp.buf.hover, desc = "Hover" },
--       { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
--       { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
--       { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },

local function buffer_include(name)
    if not name then
        return false
    end
    -- exclude names like ['.*neo-tree filesystem.*', 'term://.*']
    local exclusion_patterns = {
        ".*neo%-tree filesystem.*",
        "term://.*",
    }
    for _, pattern in ipairs(exclusion_patterns) do
        if string.match(name, pattern) then
            return false
        end
    end
    return true
end
-- jump into file directory
vim.keymap.set("n", "<leader>G", function()
    local bufname = vim.api.nvim_buf_get_name(0)
    if not buffer_include(bufname) then
        return
    end
    local dirname = vim.fs.dirname(bufname)
    vim.cmd("cd " .. dirname)
end)

function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    -- vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
    -- vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
    -- vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set("t", "<C-j>", [[<Cmd>ToggleTerm<CR>]], opts)
    vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
    -- vim.keymap.set('t', '<C-L>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
