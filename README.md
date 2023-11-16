<section align="center">
  <a href="https://github.com/rcasia/neotest-bash/actions/workflows/makefile.yml">
    <img src="https://github.com/rcasia/neotest-bash/actions/workflows/makefile.yml/badge.svg">
  </a>
  <h1>neotest-bash</h1>
  <p> <a href="https://github.com/rcarriga/neotest">Neotest</a> adapter for Bash, using <a href="https://github.com/TypedDevs/bashunit">bashunit</a></p>
</section>

![preview](https://github.com/rcasia/neotest-bash/assets/31012661/2dd406b4-5cba-41b7-9e3c-fe68197fcd6c)


## Work in Progress
:full_moon: :full_moon:  :full_moon: :last_quarter_moon: :new_moon: :new_moon: :new_moon: :new_moon: :new_moon: :new_moon: :new_moon:

## 🔧 Installation

It requires [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
>Make sure you have the bash parser installed. Use `:TSInstall bash`

[vim-plug](https://github.com/junegunn/vim-plug)
```vim
Plug 'rcasia/neotest-bash'
```

## ⚙ Configuration
```lua
require("neotest").setup({
  adapters = {
    require("neotest-bash")
  }
})
```
