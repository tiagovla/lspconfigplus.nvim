![logo](https://i.imgur.com/frat8YM.png)

## About
This plugin extends the functionality of [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) allowing asynchronous installation, update and removal of language servers.

## Installation

[packer](https://github.com/wbthomason/packer.nvim)
```lua
use {'tiagovla/lspconfigplus.nvim', requires = {'neovim/nvim-lspconfig'}}
```

## Usage
It's as simple as replacing ``require('lspconfig')`` by ``require('lspconfigplus')`` .
### Commands:
* `:LspInstallConfigured` to install all configured language servers (those with `require('lspconfigplus').<server>.setup{}` in your config).
* `:LspInstall <server>` to install the language server for `<server>` (e.g. `:LspInstall pyright`).
* `:LspUpdate <server>` to update the language server for `<server>`.
* `:LspUninstall <server>` to uninstall the language server for `<server>`.
* `:LspInstallAll` to install all available language servers.
* `:LspUpdateAll` to update all available language servers.
* `:LspUninstallAll` to uninstall all available language servers.

## Supported language servers so far
| Language    | Language Server                   |
|-------------|-----------------------------------|
| bash        | bashls                            |
| general     | efm                               |
| latex       | texlab                            |
| lua         | sumneko_lua                       |
| python      | pyright                           |
| typescript  | tsserver                          |
| vim         | vimls                             |
| yaml        | yamlls                            |

## Examples
#### simple configuration
```lua
local lspconfigplus = require('lspconfigplus')
lspconfigplus.pyright.setup {}
lspconfigplus.tsserver.setup {}
lspconfigplus.texlab.setup {}
```
#### sumneko_lua
```lua
local lspconfigplus = require('lspconfigplus')
lspconfigplus.sumneko_lua.setup {
    settings = {
        Lua = {
            diagnostics = {globals = {"vim", "use"}},
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                },
                maxPreload = 10000
            }
        }
    }
}

```

#### efm
```lua
local lspconfigplus = require('lspconfigplus')
local efm_cfg = require('lspconfigplus.extra')["efm"]
lspconfigplus.efm.setup {
    init_options = {documentFormatting = true, codeAction = false},
    filetypes = {
        "cmake", "cpp", "css", "html", "json", "lua", "python", "sh", "tex",
        "yaml"
    },
    settings = {
        rootMarkers = {".git/"},
        languages  = {
            cmake  = {efm_cfg.cmake_format},
            cpp    = {efm_cfg.prettier},
            css    = {efm_cfg.prettier},
            html   = {efm_cfg.prettier},
            json   = {efm_cfg.prettier},
            lua    = {efm_cfg.lua_format},
            python = {efm_cfg.isort, efm_cfg.yapf},
            sh     = {efm_cfg.shellcheck, efm_cfg.shfmt},
            tex    = {efm_cfg.latexindent},
            yaml   = {efm_cfg.prettier}
        }
    }
}

```
## Scripts
If you don't want any of this, you can still manually run the [scripts](/lua/lspconfigplus/servers).

## Inspiration
Heavly inspired by [nvim-lspinstall](https://github.com/kabouzeid/nvim-lspinstall) without the things that annoy me:
* using language names instead of server names (e.g. `python` instead of `pyright`)
* only supporting one language server per language (I can choose, okay?!)
* asking for permission (Install python language server? Yes/Cancel)
* opening terminals
* no update without full installation

