-- fuzzy search
local function recentFiles()
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local make_entry = require("telescope.make_entry")

    local current_buffer = vim.api.nvim_get_current_buf()
    local current_file = vim.api.nvim_buf_get_name(current_buffer)
    local results = {}

    for _, buffer in ipairs(vim.split(vim.fn.execute(":buffers! t"), "\n")) do
        local match = tonumber(string.match(buffer, "%s*(%d+)"))
        local open_by_lsp = string.match(buffer, "line 0$")
        if match and not open_by_lsp then
            local file = vim.api.nvim_buf_get_name(match)
            if vim.loop.fs_stat(file) and match ~= current_buffer then
                table.insert(results, file)
            end
        end
        if #results == 15 then
            break
        end
    end

    for _, file in ipairs(vim.v.oldfiles) do
        local file_stat = vim.loop.fs_stat(file)
        if file_stat and file_stat.type == "file" and not vim.tbl_contains(results, file) and file ~= current_file then
            table.insert(results, file)
        end
        if #results == 25 then
            break
        end
    end

    pickers
        .new({}, {
            prompt_title = "RecentFiles",
            __locations_input = true,
            finder = finders.new_table({
                results = results,
                entry_maker = make_entry.gen_from_file({}),
            }),
            sorter = conf.file_sorter({}),
            previewer = conf.grep_previewer({}),
        })
        :find()
end

return {
    "nvim-telescope/telescope.nvim",
    -- tag = '0.1.1',
    cmd = "Telescope",
    version = false,
    keys = {
        { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
        { "<leader>/", "<cmd>Telescope live_grep<CR>", desc = "live grep" },
        { "<leader>r", recentFiles, desc = "Recent" },
        { "<leader>f", ":Telescope find_files <CR>", desc = "find files" },
        {
            "gd",
            function()
                require("telescope.builtin").lsp_definitions({ reuse_win = true })
            end,
            desc = "split goto definitions",
        },
        {
            "gr",
            function()
                require("telescope.builtin").lsp_references({})
            end,
            desc = "goto references",
        },
        {
            "gI",
            function()
                require("telescope.builtin").lsp_implementations({ reuse_win = true })
            end,
            desc = "Goto Implementation",
        },
        {
            "gy",
            function()
                require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
            end,
            desc = "Goto T[y]pe Definition",
        },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("telescope").setup({
            pickers = {
                buffers = {
                    sort_lastused = true,
                },
                oldfiles = {
                    include_current_session = false,
                    cwd_only = false,
                },
            },
        })
    end,
}

-- fuzzy finder
-- {
--     "nvim-telescope/telescope.nvim",
--     commit = vim.fn.has("nvim-0.9.0") == 0 and "057ee0f8783" or nil,
--     cmd = "Telescope",
--     version = false, -- telescope did only one release, so use HEAD for now
--     keys = {
--         { "<leader>,",       "<cmd>Telescope buffers show_all_buffers=true<cr>",       desc = "Switch Buffer" },
--         { "<leader>/",       Util.telescope("live_grep"),                              desc = "Grep (root dir)" },
--         { "<leader>:",       "<cmd>Telescope command_history<cr>",                     desc = "Command History" },
--         { "<leader><space>", Util.telescope("files"),                                  desc = "Find Files (root dir)" },
--         -- find
--         { "<leader>fb",      "<cmd>Telescope buffers<cr>",                             desc = "Buffers" },
--         { "<leader>ff",      Util.telescope("files"),                                  desc = "Find Files (root dir)" },
--         { "<leader>fF",      Util.telescope("files", { cwd = false }),                 desc = "Find Files (cwd)" },
--         { "<leader>fR",      Util.telescope("oldfiles", { cwd = vim.loop.cwd() }),     desc = "Recent (cwd)" },
--         -- git
--         { "<leader>gc",      "<cmd>Telescope git_commits<CR>",                         desc = "commits" },
--         { "<leader>gs",      "<cmd>Telescope git_status<CR>",                          desc = "status" },
--         -- search
--         { "<leader>sa",      "<cmd>Telescope autocommands<cr>",                        desc = "Auto Commands" },
--         { "<leader>sb",      "<cmd>Telescope current_buffer_fuzzy_find<cr>",           desc = "Buffer" },
--         { "<leader>sc",      "<cmd>Telescope command_history<cr>",                     desc = "Command History" },
--         { "<leader>sC",      "<cmd>Telescope commands<cr>",                            desc = "Commands" },
--         { "<leader>sd",      "<cmd>Telescope diagnostics bufnr=0<cr>",                 desc = "Document diagnostics" },
--         { "<leader>sD",      "<cmd>Telescope diagnostics<cr>",                         desc = "Workspace diagnostics" },
--         { "<leader>sg",      Util.telescope("live_grep"),                              desc = "Grep (root dir)" },
--         { "<leader>sG",      Util.telescope("live_grep", { cwd = false }),             desc = "Grep (cwd)" },
--         { "<leader>sh",      "<cmd>Telescope help_tags<cr>",                           desc = "Help Pages" },
--         { "<leader>sH",      "<cmd>Telescope highlights<cr>",                          desc = "Search Highlight Groups" },
--         { "<leader>sk",      "<cmd>Telescope keymaps<cr>",                             desc = "Key Maps" },
--         { "<leader>sM",      "<cmd>Telescope man_pages<cr>",                           desc = "Man Pages" },
--         { "<leader>sm",      "<cmd>Telescope marks<cr>",                               desc = "Jump to Mark" },
--         { "<leader>so",      "<cmd>Telescope vim_options<cr>",                         desc = "Options" },
--         { "<leader>sR",      "<cmd>Telescope resume<cr>",                              desc = "Resume" },
--         { "<leader>sw",      Util.telescope("grep_string"),                            desc = "Word (root dir)" },
--         { "<leader>sW",      Util.telescope("grep_string", { cwd = false }),           desc = "Word (cwd)" },
--         { "<leader>uC",      Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
--         {
--             "<leader>ss",
--             Util.telescope("lsp_document_symbols", {
--                 symbols = {
--                     "Class",
--                     "Function",
--                     "Method",
--                     "Constructor",
--                     "Interface",
--                     "Module",
--                     "Struct",
--                     "Trait",
--                     "Field",
--                     "Property",
--                 },
--             }),
--             desc = "Goto Symbol",
--         },
--         {
--             "<leader>sS",
--             Util.telescope("lsp_dynamic_workspace_symbols", {
--                 symbols = {
--                     "Class",
--                     "Function",
--                     "Method",
--                     "Constructor",
--                     "Interface",
--                     "Module",
--                     "Struct",
--                     "Trait",
--                     "Field",
--                     "Property",
--                 },
--             }),
--             desc = "Goto Symbol (Workspace)",
--         },
--     },
--     opts = {
--         defaults = {
--             prompt_prefix = " ",
--             selection_caret = " ",
--             mappings = {
--                 i = {
--                     ["<c-t>"] = function(...)
--                         return require("trouble.providers.telescope").open_with_trouble(...)
--                     end,
--                     ["<a-t>"] = function(...)
--                         return require("trouble.providers.telescope").open_selected_with_trouble(...)
--                     end,
--                     ["<a-i>"] = function()
--                         local action_state = require("telescope.actions.state")
--                         local line = action_state.get_current_line()
--                         Util.telescope("find_files", { no_ignore = true, default_text = line })()
--                     end,
--                     ["<a-h>"] = function()
--                         local action_state = require("telescope.actions.state")
--                         local line = action_state.get_current_line()
--                         Util.telescope("find_files", { hidden = true, default_text = line })()
--                     end,
--                     ["<C-Down>"] = function(...)
--                         return require("telescope.actions").cycle_history_next(...)
--                     end,
--                     ["<C-Up>"] = function(...)
--                         return require("telescope.actions").cycle_history_prev(...)
--                     end,
--                     ["<C-f>"] = function(...)
--                         return require("telescope.actions").preview_scrolling_down(...)
--                     end,
--                     ["<C-b>"] = function(...)
--                         return require("telescope.actions").preview_scrolling_up(...)
--                     end,
--                 },
--                 n = {
--                     ["q"] = function(...)
--                         return require("telescope.actions").close(...)
--                     end,
--                 },
--             },
--         },
--     },
-- }
