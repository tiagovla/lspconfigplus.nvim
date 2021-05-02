local M = {}

M.efm = {
    ["clang_format"] = {formatCommand = "clang-format", formatStdin = true},
    ["cmake_format"] = {formatCommand = 'cmake-format', formatStdin = true},
    ["isort"] = {formatCommand = "isort --quiet -", formatStdin = true},
    ["latexindent"] = {formatCommand = "latexindent", formatStdin = true},
    ["lua_format"] = {formatCommand = "lua-format", formatStdin = true},
    ["prettier"] = {
        formatCommand = "prettier --stdin-filepath ${INPUT}",
        formatStdin = true
    },
    ["shellcheck"] = {
        LintCommand = 'shellcheck -f gcc -x',
        lintFormats = {
            '%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m',
            '%f:%l:%c: %tote: %m'
        }
    },
    ["shfmt"] = {formatCommand = 'shfmt -ci -s -bn', formatStdin = true},
    ["yapf"] = {formatCommand = "yapf --quiet", formatStdin = true}
}

return M
