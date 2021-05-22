# nvim-treesitter-pyfold
Folding is a great way to declutter the screen from irrelevant context but
overfolding can be equally annoying.
Hence, a lua based module for nvim-treesitter, setting some sane folding 
defaults and provides an optional foldtext.

## Installation
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

## Example
#### Classes
![Classes folding](https://github.com/eddiebergman/nvim-treesitter-pyfold/blob/master/images/Classes_Folding.png)
#### Funcitons / Methods
![Functions example](https://github.com/eddiebergman/nvim-treesitter-pyfold/blob/master/images/Functions_example.png)
![Multline signature](https://github.com/eddiebergman/nvim-treesitter-pyfold/blob/master/images/Multiline_signature.png)
![Functions Based on Docs present](https://github.com/eddiebergman/nvim-treesitter-pyfold/blob/master/images/Function_based_on_doc.png)
#### Dicts, Lists, Tuples
![Dicts, Lists, Tuples folding](https://github.com/eddiebergman/nvim-treesitter-pyfold/blob/master/images/listlikes.png)

### TODO
* Getting multiple imports to fold into one line.
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

The C part of the python tree-sitter parser doesn't want to fold any 
'queryable' that only lives on one line, even if you group multiple of them
together in query. Please let me know if you know of any workaround for this!
