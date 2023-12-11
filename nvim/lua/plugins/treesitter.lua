return {
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      "https://github.com/windwp/nvim-ts-autotag",
    },
    build = ':TSUpdate',
    config = function()
      local config = require 'config'
      require('nvim-treesitter.configs').setup {
        ensure_installed = config.ts_ensure_installed,

        auto_install = true,
        autotag = {
          enable = true
        },

        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },
}
