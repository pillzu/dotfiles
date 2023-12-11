return {
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 500,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
          { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', gs.next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>ph', gs.preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
        vim.keymap.set('n', '<leader>hs', gs.stage_hunk, { desc = "[h]unk [s]tage" })
        vim.keymap.set('n', '<leader>hr', gs.reset_hunk, { desc = "[h]unk [r]eset" })
        vim.keymap.set('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
          { desc = "[h]unk [s]tage selection" })
        vim.keymap.set('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
          { desc = "[h]unk [r]eset selection" })
        vim.keymap.set('n', '<leader>hS', gs.stage_buffer, { desc = "[h]unk [S]tage All" })
        vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, { desc = "[h]unk [u]ndo" })
        vim.keymap.set('n', '<leader>hR', gs.reset_buffer, { desc = "[h]unk [R]eset buffer" })
        vim.keymap.set('n', '<leader>hb', function() gs.blame_line { full = true } end, { desc = "[h]unk [b]lame" })
        vim.keymap.set('n', '<leader>hd', gs.diffthis, { desc = "[h]unk [d]iff" })
      end,
    }
  },
}
