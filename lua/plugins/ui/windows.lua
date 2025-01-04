return {
    "anuvyklack/windows.nvim",
    dependencies = {
        "anuvyklack/middleclass",
        "anuvyklack/animation.nvim",
    },
    keys = {
        { "<Leader>z", "<cmd>WindowsMaximize<cr>", desc = "Window Maximize" },
        { "<Leader>a", "<cmd>WindowsEqualize<cr>", desc = "Windows Equalize" },
    },
    config = function()
        vim.o.winwidth = 10
        vim.o.winminwidth = 0
        vim.o.winminheight = 0
        vim.o.equalalways = false
        require("windows").setup({
            autowidth = {
                enable = false,
            },
            animation = {
                enable = true,
                duration = 200,
            },
        })
    end,
}
