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

local function is_doc_fold(s, e)
    return s:find('"""') ~= nil and e:find('"""') ~= nil
end

local function is_doc_and_body(s, e)
    return s:find('"""') ~= nil and e:find('"""') == nil
end

local function is_main_func(s, e)
    return s:find('__main__') ~= nil and s:find('__name__') ~= nil
end

local function is_dict(s, e)
    return s:find('{%s*$') ~= nil and e:find('}%s*$') ~= nil
end

local function is_list(s, e)
    return s:find('%[%s*$') ~= nil and e:find('%]%s*$') ~= nil
end

local function is_tuple(s, e)
    return s:find('%(%s*$') ~= nil and e:find('%)%s*$') ~= nil
end

function M.foldtext(lstart, lend, dashes)
    local s = fn.getline(lstart)
    local e = fn.getline(lend)

    if is_doc_fold(s, e) then
        -- replace """ with |, if nothing after | on same line,
        -- replace that with | doc
        local s2 = s
        if lstart ~= lend and s:find('"""%s*$') ~= nil then
            s2 = s:gsub('"""', 'o ') .. fn.getline(lstart+1):match("^%s*(.-)%s*$")
        end
        return s2:gsub('"""%s*', 'o ' ):gsub('o%s*$', 'o  doc')

    elseif is_doc_and_body(s, e) then
        -- replace """ with |, if noting after | on same line,
        -- replace that with "| doc, body"
        --
        local s2 = s
        if lstart ~= lend and s:find('"""%s*$') ~= nil then
            s2 = s:gsub('"""', 'o ') .. fn.getline(lstart+1):match("^%s*(.-)%s*$")
        end
        return s2:gsub('"""%s*', 'o▶ '):gsub('o▶%s*$', 'o▶  doc, body')

    elseif is_main_func(s, e) then
        return s

    elseif is_dict(s, e) then
        local nlines = tostring(lend - lstart -1)
        return s:gsub('{.*$', '{ ... }')..' ('..nlines..')'

    elseif is_list(s, e) then
        local nlines = tostring(lend - lstart -1)
        return s:gsub('%[.*$', '[ ... ]')..' ('..nlines..')'

    elseif is_tuple(s, e) then
        local nlines = tostring(lend - lstart -1)
        return s:gsub('%(.*$', '( ... )')..' ('..nlines..')'

    else
        return s:gsub('[^%s].*$', '▶  body ')
    end
end

return M
