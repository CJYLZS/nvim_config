local options = {
    number = true,
    relativenumber = true,
    -- paste = true, -- set true will effect nvim-cmp enter completion
    shiftwidth = 4,
    fileencodings= 'utf-8,gbk,ucs-bom,cp936',
    tabstop = 4,
    softtabstop = 4,
    smarttab = true,
    expandtab = true,
    list = true,
    signcolumn = "yes", -- always set signcolumn, prevent text move when first sign occured
    shada = "!,'20,f1,<50,s10,h", -- https://vi.stackexchange.com/questions/37863/limit-the-amount-of-oldfiles-in-vim-and-neovim
}
for key, value in pairs(options) do
    vim.o[key] = value
end
