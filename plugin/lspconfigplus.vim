" lua << EOF
" for k in pairs(package.loaded) do
"     if k:match(".*lspconfigplus.*") then package.loaded[k] = nil end
" end
" EOF

function! lspconfigplus#install_server(server_name)
  lua require("lspconfigplus")._root.install_server(a:server_name)
endfunction

function! lspconfigplus#update_server(server_name)
  lua require("lspconfigplus")._root.update_server(a:server_name)
endfunction

function! lspconfigplus#uninstall_server(server_name)
  lua require("lspconfigplus")._root.uninstall_server(a:server_name)
endfunction

function! lspconfigplus#install_all_servers()
    lua require("lspconfigplus")._root.install_all_servers()
endfunction

function! lspconfigplus#update_all_servers()
    lua require("lspconfigplus")._root.update_all_servers()
endfunction

function! lspconfigplus#uninstall_all_servers()
    lua require("lspconfigplus")._root.uninstall_all_servers()
endfunction

function! lspconfigplus#install_configured_servers()
    lua require("lspconfigplus")._root.install_configured_servers()
endfunction

function! lspconfigplus#available_servers()
    return luaeval('require("lspconfigplus.utils").available_servers(require("lspconfigplus.servers"))')
endfunction

function! lspconfigplus#installed_servers()
    return luaeval('require("lspconfigplus.utils").installed_servers(require("lspconfigplus.servers"))')
endfunction

function! lspconfigplus#not_installed_servers()
    return luaeval('require("lspconfigplus.utils").not_installed_servers(require("lspconfigplus.servers"))')
endfunction

command! -nargs=1 -complete=custom,s:autocomplete_install LspInstall :call lspconfigplus#install_server('<args>')
command! -nargs=1 -complete=custom,s:autocomplete_update LspUpdate :call lspconfigplus#update_server('<args>')
command! -nargs=1 -complete=custom,s:autocomplete_uninstall LspUninstall :call lspconfigplus#uninstall_server('<args>')
command! LspInstallAll :call lspconfigplus#install_all_servers()
command! LspUpdateAll :call lspconfigplus#update_all_servers()
command! LspUninstallAll :call lspconfigplus#uninstall_all_servers()
command! LspInstallConfigured :call lspconfigplus#install_configured_servers()

function! s:autocomplete_install(arg, line, pos) abort
  return join(lspconfigplus#not_installed_servers(), "\n")
endfunction

function! s:autocomplete_update(arg, line, pos) abort
  return join(lspconfigplus#installed_servers(), "\n")
endfunction

function! s:autocomplete_uninstall(arg, line, pos) abort
  return join(lspconfigplus#installed_servers(), "\n")
endfunction

