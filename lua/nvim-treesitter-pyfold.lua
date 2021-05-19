local M = {}

M.is_supported = function (lang) return lang == 'python' end

function M.init()
    require('nvim-treesitter').define_modules({
        pyfold = {
            enable = true,
            disable = {},
            custom_foldtext = true,
            module_path = "nvim-treesitter-pyfold.folding",
            is_supported = M.is_supported
        }
    })
end


return M
