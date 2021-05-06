local U = {}
local api = vim.api
local logger = require("lspconfigplus.logger")

function U.set_extmark(buf, ns, id, line, col)
    if not api.nvim_buf_is_valid(buf) then return end
    local opts = {id = id}
    local result, mark_id = pcall(api.nvim_buf_set_extmark, buf, ns, line, col, opts)
    if result then return mark_id end
    if not id then id = 0 end
    return api.nvim_buf_set_extmark(buf, ns, id, line, col, {})
end

function U.get_extmark_by_id(buf, ns, id)
    local result, line, col = pcall(api.nvim_buf_get_extmark_by_id, buf, ns, id, {})
    if result then
        return line, col
    else
        logger.error("Failed to get extmark: " .. line)
    end
    return api.nvim_buf_get_extmark_by_id(buf, ns, id)
end

return U
