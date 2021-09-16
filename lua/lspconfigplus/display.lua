local api = vim.api
local fmt = string.format
local config = require("lspconfigplus.config")["display"]
local utils = require("lspconfigplus.utils.display")

local Display = {}
Display.__index = Display

local keymaps = {
    quit = {
        lhs = "q",
        rhs = '<cmd>lua require"lspconfigplus.display".quit()<cr>',
        action = "quit",
    },
    toggle_info = {
        lhs = "i",
        rhs = '<cmd>lua require"lspconfigplus.display".toggle_info()<cr>',
        action = "show more info",
    },
}

local filetype_cmds = {
    "setlocal buftype=nofile bufhidden=wipe nobuflisted nolist noswapfile nowrap nospell nonumber norelativenumber nofoldenable signcolumn=no",
    "syntax clear",
    "syn match lspconfigplusWorking /^ " .. config.working_sym .. "/",
    "syn match lspconfigplusSuccess /^ " .. config.done_sym .. "/",
    "syn match lspconfigplusFail /^ " .. config.error_sym .. "/",
    "syn match lspconfigplusStatus /\\(^+.*—\\)\\@<=\\s.*$/",
    "syn match lspconfigplusStatusSuccess /\\(^ " .. config.done_sym .. ".*\\)\\@<=\\s.*$/",
    "syn match lspconfigplusStatusFail /\\(^ " .. config.error_sym .. ".*\\)\\@<=\\s.*$/",
    "syn match lspconfigplusStatusCommit /\\(^\\*.*—\\)\\@<=\\s.*$/",
    "syn match lspconfigplusHash /\\(\\s\\)[0-9a-f]\\{7,8}\\(\\s\\)/",
    "syn match lspconfigplusRelDate /([^)]*)$/",
    "syn match lspconfigplusProgress /\\(\\[\\)\\@<=[\\=]*/",
    "syn match lspconfigplusOutput /\\(Output:\\)\\|\\(Commits:\\)\\|\\(Errors:\\)/",
    [[syn match lspconfigplusTimeHigh /\d\{3\}\.\d\+ms/]],
    [[syn match lspconfigplusTimeMedium /\d\{2\}\.\d\+ms/]],
    [[syn match lspconfigplusTimeLow /\d\.\d\+ms/]],
    [[syn match lspconfigplusTimeTrivial /0\.\d\+ms/]],
    [[syn match lspconfigplusPackageNotLoaded /(not loaded)$/]],
    [[syn match lspconfigplusPackageName /\(^\ • \)\@<=[^ ]*/]],
    [[syn match lspconfigplusString /\v(''|""|(['"]).{-}[^\\]\2)/]],
    [[syn match lspconfigplusBool /\<\(false\|true\)\>/]],
}

function Display:create()
    local display = {}
    setmetatable(display, Display)
    display.buf = nil
    display.win = nil
    self.marks = {}
    self.plugins = {}
    self.ns = api.nvim_create_namespace("")
    return display
end

function Display:set_lines(start_idx, end_idx, lines)
    if not self:valid_display() then
        return
    end
    api.nvim_buf_set_option(self.buf, "modifiable", true)
    api.nvim_buf_set_lines(self.buf, start_idx, end_idx, true, lines)
    api.nvim_buf_set_option(self.buf, "modifiable", false)
end

function Display:decrement_headline_count()
    if not self:valid_display() then
        return
    end
    local cursor_pos = api.nvim_win_get_cursor(self.win)
    api.nvim_win_set_cursor(self.win, { 1, 0 })
    api.nvim_buf_set_option(self.buf, "modifiable", true)
    vim.fn.execute("normal! ")
    api.nvim_buf_set_option(self.buf, "modifiable", false)
    api.nvim_win_set_cursor(self.win, cursor_pos)
end

function Display:update_headline_message(message)
    if not self:valid_display() then
        return
    end
    local headline = "lspconfig+" .. " - " .. message
    local width = api.nvim_win_get_width(self.win) - 2
    local pad_width = math.max(math.floor((width - string.len(headline)) / 2.0), 0)
    self:set_lines(0, 2 - 1, { string.rep(" ", pad_width) .. headline .. string.rep(" ", pad_width) })
end

function Display:task_start(server, message)
    local function fn(server_, message_)
        if not self:valid_display() then
            return
        end
        if self.marks[server_] then
            self:task_update(server_, message_)
            return
        end
        self.running = true
        self:set_lines(2, 2, { fmt(" %s %s: %s", config.working_sym, server_, message_) })
        self.marks[server] = utils.set_extmark(self.buf, self.ns, nil, 2, 0)
    end
    return vim.schedule_wrap(fn)(server, message)
end

function Display:task_succeeded(server, message)
    local function fn(server_, message_)
        if not self:valid_display() then
            return
        end
        local line, _ = utils.get_extmark_by_id(self.buf, self.ns, self.marks[server_])
        self:set_lines(line[1], line[1] + 1, { fmt(" %s %s: %s", config.done_sym, server_, message_) })
        api.nvim_buf_del_extmark(self.buf, self.ns, self.marks[server_])
        self.marks[server_] = nil
        self:decrement_headline_count()
    end
    return vim.schedule_wrap(fn)(server, message)
end

function Display:task_failed(server, message)
    local function fn(server_, message_)
        if not self:valid_display() then
            return
        end
        local line, _ = utils.get_extmark_by_id(self.buf, self.ns, self.marks[server_])
        self:set_lines(line[1], line[1] + 1, { fmt(" %s %s: %s", config.error_sym, server_, message_) })
        api.nvim_buf_del_extmark(self.buf, self.ns, self.marks[server_])
        self.marks[server_] = nil
        self:decrement_headline_count()
    end
    return vim.schedule_wrap(fn)(server, message)
end

function Display:task_update(server, message)
    local function fn(server_, message_)
        if not self:valid_display() then
            return
        end
        if not self.marks[server_] then
            return
        end
        local line, _ = utils.get_extmark_by_id(self.buf, self.ns, self.marks[server_])
        self:set_lines(line[1], line[1] + 1, { fmt(" %s %s: %s", config.working_sym, server_, message_) })
        utils.set_extmark(self.buf, self.ns, self.marks[server_], line[1], 0)
    end
    return vim.schedule_wrap(fn)(server, message)
end

function Display:quit()
    vim.fn.execute("q!", "silent")
end

function Display:toggle_info()
    print("showing more info")
end

function Display:make_header()
    local width = api.nvim_win_get_width(0)
    api.nvim_buf_set_lines(self.buf, 0, 1, true, {
        string.rep(" ", 3) .. "lspconfig+",
        " " .. string.rep("-", width - 2) .. " ",
    })
end

function Display:setup_window()
    for _, m in pairs(keymaps) do
        if m.lhs then
            api.nvim_buf_set_keymap(self.buf, "n", m.lhs, m.rhs, { nowait = true, silent = true })
        end
    end
    for _, c in ipairs(filetype_cmds) do
        vim.cmd(c)
    end
end

function Display:valid_display()
    return self and api.nvim_buf_is_valid(self.buf) and api.nvim_win_is_valid(self.win)
end

function Display:open()
    if self.win and api.nvim_win_is_valid(self.win) then
        api.nvim_win_close(self.win, true)
        self.win = nil
    end
    vim.cmd("65vnew [lspinstall+]")
    self.win = api.nvim_get_current_win()
    self.buf = api.nvim_get_current_buf()
    vim.bo.buftype = "nofile"
    vim.bo.buflisted = false
    api.nvim_buf_set_option(self.buf, "modifiable", true)
    api.nvim_buf_set_option(self.buf, "buflisted", false)
    api.nvim_buf_set_option(self.buf, "filetype", "lspconfigplus")
    self:make_header()
    self:setup_window()
end

local disp = Display:create()

vim.cmd([[command! LspOpen :lua require("lspconfigplus.display"):open()]])

return disp
