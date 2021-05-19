# nvim-treesitter-pyfold (WIP)
A lua based module for nvim-treesitter, sets sane folding defaults and provides
an optional foldtext.

### Installation
Using your favourite package manager
```
# vim-plug
Plug 'nvim-treesitter-pyfold'

# Packer
    ...
    use 'eddiebergman/nvim-treesitter-pyfold'
    ...
}
```

Once your package manager has installed the package, in your nvim-treesitter
setup, you simply enable the package with:
```lua
require('nvim-treesitter.configs').setup {
    ...
    pyfold = {
        enable = true
        custom_foldtext = true -- Sets provided foldtext on window where module is active
    }
    ...
}
```

### Example
TODO

