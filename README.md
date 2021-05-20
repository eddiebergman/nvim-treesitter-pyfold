# nvim-treesitter-pyfold (WIP)
A lua based module for nvim-treesitter, sets sane folding defaults and provides
an optional foldtext.

### Installation
Using your favourite package manager
```lua
# vim-plug
Plug 'nvim-treesitter-pyfold'

# Packer
require('packer').setup {
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
![Example of folding](https://github.com/eddiebergman/nvim-treesitter-pyfold/blob/master/images/folding.png)

### TODO
* Getting multiple imports to fold into one line, if anyone is aware how to do
    this with treesitter, please feel free to drop an issue!
```Python
# Code
import one
import two
import three
from x import y
import a as b
from z import ( 
    alpha, beta, phi
)

# Desired
-- imports
```

* List, Dict folding
```Python
# Code
my_dict = {
    'k1' : 'v1'
    'k2' : 'v2'
}

my_list = [
    'item1',
    'item2'
]

# Desired
my_dict = { ... }

my_list = [ ... ]
```



