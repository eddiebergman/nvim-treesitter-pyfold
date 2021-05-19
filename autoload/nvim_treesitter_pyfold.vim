function! nvim_treesitter_pyfold#foldtext()
    return luaeval(printf("require('nvim-treesitter-pyfold.folding').foldtext(%d, %d, %d)", v:foldstart, v:foldend, v:folddashes))
endfunction
