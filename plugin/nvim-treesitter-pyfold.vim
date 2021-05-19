if exists('g:loaded_nvim_treesitter_pyfold') | finish | endif

let s:save_cpo = &cpo
set cpo&vim

lua require('nvim-treesitter-pyfold').init()

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_nvim_treesitter_pyfold = 1
