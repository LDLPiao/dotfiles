-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
   'nvim-neo-tree/neo-tree.nvim',
   version = '*',
   dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
   },
   lazy = false,
   config = function()
      require('neo-tree').setup {
         event_handlers = {

            {
               event = 'file_open_requested',
               handler = function()
                  -- auto close
                  -- vim.cmd("Neotree close")
                  -- OR
                  require('neo-tree.command').execute { action = 'close' }
               end,
            },
         },
         window = {
            mappings = {
               ['.'] = {
                  'toggle_hidden',
               },
               ['l'] = {
                  'set_root',
               },
               ['h'] = {
                  'navigate_up',
               },
            },
         },
      }
      vim.keymap.set('n', '<leader>e', '<Cmd>Neotree toggle<CR>', { desc = '󰙅 Neotree toggle' })
   end,
}
