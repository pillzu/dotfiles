return {
  'codota/tabnine-nvim',
  build = "./dl_binaries.sh",
  config = function()
    local opts = {
      accept_keymap = "~",
      suggestion_color = {
        gui = "#E0B0FF",
        cterm = 244
      },
    }
    require('tabnine').setup(opts)
  end
}
