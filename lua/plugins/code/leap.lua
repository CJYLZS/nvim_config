return {
    "ggandor/leap.nvim",
    enabled = true,
    keys = {
        { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
        { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
        { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
    config = function(_, opts)
        local leap = require("leap")
        for k, v in pairs(opts) do
            leap.opts[k] = v
        end
        -- leap.opts.max_phase_one_targets = 0
        leap.add_default_mappings(true)
        vim.keymap.del({ "x", "o" }, "x")
        vim.keymap.del({ "x", "o" }, "X")
        vim.keymap.set('n',        's', '<Plug>(leap)')
        vim.keymap.set('n',        'S', '<Plug>(leap-from-window)')
        vim.keymap.set({'x', 'o'}, 's', '<Plug>(leap-forward)')
        vim.keymap.set({'x', 'o'}, 'S', '<Plug>(leap-backward)')
    end,
}
