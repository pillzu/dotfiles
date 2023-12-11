return {
  {
    'nvimtools/none-ls.nvim',
    config = function()
      local null_ls = require 'null-ls'
      local config = require('config').null_ls_servers
      local builtins = require('null-ls').builtins
      null_ls.setup {
        sources = {
          builtins.diagnostics.codespell,
          -- builtins.diagnostics.eslint_d,
          builtins.formatting.rustywind,
        }
      }
    end,
  },
}
