return {
  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      {
        'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {},
      },
    },
    config = function()
      require("trouble").setup()
      vim.keymap.set("n", "<leader>tt", function() require("trouble").open() end, { desc = "Trouble: Toggle" })
      vim.keymap.set("n", "<leader>tw", function() require("trouble").open("workspace_diagnostics") end,
        { desc = "Trouble: Workspace Diagnostics" })
      vim.keymap.set("n", "<leader>td", function() require("trouble").open("document_diagnostics") end,
        { desc = "Trouble: Document Diagnostics" })
      vim.keymap.set("n", "<leader>tq", function() require("trouble").open("quickfix") end,
        { desc = "Trouble: Quick Fix" })
      vim.keymap.set("n", "<leader>tl", function() require("trouble").open("loclist") end, { desc = "Trouble: Loc list" })
      vim.keymap.set("n", "gR", function() require("trouble").open("lsp_references") end,
        { desc = "Trouble: Lsp References" })
      vim.keymap.set("n", "gR", function() require("trouble").open("lsp_references") end,
        { desc = "Trouble: Lsp References" })
    end
  }
}
