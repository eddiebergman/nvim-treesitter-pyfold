local queries = require('vim.treesitter.query')
local configs = require('nvim-treesitter.configs')
local invalidate_query_cache = require('nvim-treesitter.query').invalidate_query_cache

local api = vim.api
local fn = vim.fn
local exec = vim.api.nvim_exec

local rtp_search_str = '**/nvim-treesitter-pyfold/queries/python/folds.scm'

local M = {
    cache = {}
}

local function folds_path()
    if M.cache['fold_path'] == nil then
        M.cache['fold_path'] = api.nvim_get_runtime_file(rtp_search_str, false)[1]
    end

    return M.cache['fold_path']
end

local function readfile(path)
    local f = io.open(path, 'r')
    local content = f:read('*a')
    f:close()
    return content
end

function M.attach(bufnr, lang)
    local config = configs.get_module('pyfold')

    -- Set fold regions
    local fold_query = readfile(folds_path())
    queries.set_query('python', 'folds', fold_query)

    -- Change to custom foldtext
    if config.custom_foldtext == true then
        M.prev_foldtext = exec('echo &foldtext', true)
        vim.wo.foldtext = 'nvim_treesitter_pyfold#foldtext()'
    end

end

function M.detach(bufnr)
    local config = configs.get_module('pyfold')
    invalidate_query_cache('python', 'folds')

    if config.custom_foldtext == true then
        vim.wo.foldtext = M.prev_foldtext
    end
end

function M.is_supported(lang)
    return lang == 'python'
end

local function isdocfold(s, e)
    return s:find('"""') ~= nil and e:find('"""') ~= nil
end

local function ismainfunc(s, e)
    return s:find('__main__') ~= nil and s:find('__name__') ~= nil
end

function M.foldtext(lstart, lend, dashes)
    local s = fn.getline(lstart)
    local e = fn.getline(lend)

    if isdocfold(s, e) then
        return s:gsub('"""%s*$', '""" ... """' )

    elseif ismainfunc(s, e) then
        return s

    else
        return s:gsub('[^%s].*$', '{ ... }')
    end
end

return M
