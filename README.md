![logo](https://i.imgur.com/frat8YM.png)

## About
This plugin extends the functionality of [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) allowing asynchronous isolated installation, update and removal of language servers, formatters and linters. It requires Neovim v0.5.0+.

## Installation

[packer](https://github.com/wbthomason/packer.nvim)
```lua
use {'tiagovla/lspconfigplus.nvim', requires = {'neovim/nvim-lspconfig'}}
```

## Usage
It's as simple as replacing ``require('lspconfig')`` by ``require('lspconfigplus')`` .
### Commands:
* `:LspInstall` to install all configured language servers, formatters and linters.
* `:LspUpdate` to update all configured language servers, formatters and linters.
* `:LspClean` to clean installed servers, formatters and linters that are not configured anymore.

## Support
#### Language servers so far
| Language    | Language Server     |
|-------------|---------------------|
| bash        | bashls              |
| c, cpp      | clangd              |
| cmake       | cmake               |
| general     | efm                 |
| latex       | texlab              |
| lua         | sumneko_lua         |
| python      | pyright             |
| typescript  | tsserver            |
| vim         | vimls               |
| yaml        | yamlls              |

#### Formatters so far
| Language    | Formatter           |
|-------------|---------------------|
| cmake       | cmakelang           |
| lua         | lua                 |
| python      | isort, yapf         |

#### Linters so far
| Language    | Formatter           |
|-------------|---------------------|
| python      | flake8              |

## Examples
#### Simple configuration
```lua
local lspconfigplus = require('lspconfigplus')
lspconfigplus.pyright.setup {}
lspconfigplus.tsserver.setup {}
lspconfigplus.texlab.setup {}
```
#### Bulk setup
```lua
local servers = {"pyright", "vimls", "tsserver", "yamlls", "bashls", "dockerls", "cmake", "clangd"}
lspconfigplus.bulk_setup(servers, {on_attach = on_attach})
```
#### Overwriting defaults
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

#### General server
```lua
local lspconfigplus = require('lspconfigplus')
local isort = lspconfigplus.formatters.isort.setup {}
local yapf = lspconfigplus.formatters.yapf.setup {}
local lua_format = lspconfigplus.formatters.lua_format.setup {}
local efm_cfg = require('lspconfigplus.extra')["efm"]
lspconfigplus.efm.setup {
    init_options = {documentFormatting = true, codeAction = false},
    filetypes = {"lua", "python"},
    settings = {
        rootMarkers = {".git/"},
        languages  = {
            lua    = {lua_format},
            python = {isort, yapf},
        }
    }
}

```
## Scripts
If you don't want any of this, you can still manually run the [scripts](/lua/lspconfigplus/servers).

## Inspiration
Heavly inspired by [nvim-lspinstall](https://github.com/kabouzeid/nvim-lspinstall) and [packer.nvim](https://github.com/wbthomason/packer.nvim)
