# neotest-bash

[Neotest](https://github.com/rcarriga/neotest) adapter for Bash, using Bashunit.


## 🔧 Installation

It requires [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

Using vim-plug:
```vim
Plug 'rcasia/neotest-bash', { 'do': ':TSInstall bash' }
```

## ⚙ Configuration
```lua
require("neotest").setup({
  adapters = {
    require("neotest-bash")
  }
})
```
