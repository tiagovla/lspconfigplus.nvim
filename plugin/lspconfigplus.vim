" lua << EOF
" for k in pairs(package.loaded) do
"     if k:match(".*lspconfigplus.*") then package.loaded[k] = nil end
" end
" EOF
if exists('g:lspconfigplus')
  finish
endif
let g:lspconfigplus = 1

lua require('lspconfigplus.colors')

command! LspInstall :silent! lua require('lspconfigplus.install').install()
command! LspUpdate :silent! lua require('lspconfigplus.update').update()
command! LspClean :silent! lua require('lspconfigplus.clean').clean()
command! LspStatus :silent! lua require('lspconfigplus.status').status()
