return {

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        -- telescope file browser
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        lazy = false,
      },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- make sure you have `make`
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },

    config = function()
      ---@diagnostic disable-next-line: deprecated
      local vimgrep_arguments = { unpack(require("telescope.config").values.vimgrep_arguments) }
      -- I want to search in hidden/dot files.
      table.insert(vimgrep_arguments, "--hidden")
      -- I don't want to search in the `.git` directory.
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/.git/*")

      require('telescope').setup {
        pickers = {
          find_files = {
            find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
          }
        },
        defaults = {
          vimgrep_arguments = vimgrep_arguments,
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
        },
        extensions = {
          file_browser = {
            theme = "dropdown",
            hijack_netrw = true,
          },
        },
      }

      -- Enable telescope fzf native, if installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require("telescope").load_extension "file_browser")

      vim.api.nvim_set_keymap(
        "n",
        "<leader>fb",
        ":Telescope file_browser<CR>",
        { noremap = true, desc = "[F]ile [B]rowser" }
      )

      vim.keymap.set('n', '<leader>fo', require('telescope.builtin').oldfiles,
        { desc = '[F]ind recently [o]pened files' })
      vim.keymap.set('n', '<leader><leader>', require('telescope.builtin').buffers,
        { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_status, { desc = 'View [G]it [S]tatus' })
      vim.keymap.set('n', '<leader>gf', function()
        if require("obsidian").util.cursor_on_markdown_link() then
          return "<cmd>ObsidianFollowLink<CR>"
        else
          require('telescope.builtin').git_files()
        end
      end, { desc = 'Search [G]it [F]iles' })
      vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
      vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[F]ind [H]elp' })
      vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[F]ind current [W]ord' })
      vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[F]ind by [G]rep' })
      vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })
      vim.keymap.set('n', '<C-n>', ":NvimTreeToggle<CR>", { desc = "nvim-tree: Toggle" })
      vim.keymap.set('n', '<leader>l', ":NvimTreeFocus<CR>", { desc = "nvim-tree: Focus" })
    end
  },
}
