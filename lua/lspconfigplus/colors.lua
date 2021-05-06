local highlights = {
    'hi def link lspconfigplusStatus            Type',
    'hi def link lspconfigplusStatusSuccess     Constant',
    'hi def link lspconfigplusStatusFail        WarningMsg',
    'hi def link lspconfigplusPackageName       Label',
    'hi def link lspconfigplusPackageNotLoaded  Comment',
    'hi def link lspconfigplusString            String',
    'hi def link lspconfigplusBool              Boolean',
    'hi def link lspconfigplusWorking           SpecialKey',
    'hi def link lspconfigplusSuccess           Question',
    'hi def link lspconfigplusFail              ErrorMsg',
    'hi def link lspconfigplusHash              Identifier',
    'hi def link lspconfigplusRelDate           Comment',
    'hi def link lspconfigplusProgress          Boolean',
    'hi def link lspconfigplusOutput            Type'
}
for _, c in ipairs(highlights) do vim.cmd(c) end
