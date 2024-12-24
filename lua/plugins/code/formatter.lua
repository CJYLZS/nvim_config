-- formatter

local function system(cmd)
    local output = vim.fn.system(cmd)
    if vim.v.shell_error ~= 0 then
        vim.notify(cmd .. " return code " .. vim.v.shell_error, vim.log.levels.ERROR)
        vim.notify(output, vim.log.levels.INFO)
    end
end
local function py_formatter(filepath)
    system("python3 -m autopep8 --ignore=E501,E402 -i " .. vim.fn.shellescape(filepath))
end
local function lua_formatter(filepath)
    system("stylua --indent-type Spaces --indent-width 4 " .. vim.fn.shellescape(filepath))
end
local function sh_formatter(filepath)
    system("shfmt -i 4 -w " .. vim.fn.shellescape(filepath))
end
local function go_formatter(filepath)
    system("gofmt -s -w " .. vim.fn.shellescape(filepath))
end
local function sql_formatter(filepath)
    system("sqlfmt " .. vim.fn.shellescape(filepath))
end

local formatter_table = {
    py = py_formatter,
    lua = lua_formatter,
    sh = sh_formatter,
    go = go_formatter,
    sql = sql_formatter,
}

function GetFileExtension(filepath)
    return filepath:match("^.+%.(.+)$")
end

_G.my_formatter = function()
    -- Get the current active buffer
    local current_buffer = vim.api.nvim_get_current_buf()

    -- Check if the buffer has a file associated with it
    if vim.api.nvim_buf_get_option(current_buffer, "buftype") ~= "" then
        print("No file associated with the buffer")
        return
    end

    -- Get the real filepath of the buffer
    local real_filepath = vim.api.nvim_buf_get_name(current_buffer)
    if real_filepath == "" then
        print("No filepath associated with the buffer")
        return
    end

    -- Check if the file is a Python file
    local ext = GetFileExtension(real_filepath)
    if formatter_table[ext] == nil then
        vim.notify(" not found formatter for " .. ext .. " file")
        return
    end
    print("format for " .. ext .. " file")
    vim.cmd("silent :w")
    formatter_table[ext](real_filepath)
    vim.cmd("silent :e!")

    -- print('Python file formatted')
end

vim.api.nvim_set_keymap("n", "<Esc>F", ":lua my_formatter()<CR>", { noremap = true, silent = true })
