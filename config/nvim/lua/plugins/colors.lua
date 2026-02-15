return {
   {
      'f4z3r/gruvbox-material.nvim',
      name = 'gruvbox-material',
      lazy = false,
      priority = 1000,
      opts = {},
      config = function()
         -- values shown are defaults and will be used if not provided
         require('gruvbox-material').setup {
            italics = true, -- enable italics in general
            contrast = 'medium', -- set contrast, can be any of "hard", "medium", "soft"
            comments = {
               italics = true, -- enable italic comments
            },
            background = {
               transparent = true, -- set the background to be opaque
            },
            float = {
               force_background = false, -- set to true to force backgrounds on floats even when
               -- background.transparent is set
               background_color = nil, -- set color for float backgrounds. If nil, uses the default color set
               -- by the color scheme
            },
            signs = {
               force_background = false, -- set to true to force backgrounds on signs even when
               -- background.transparent is set
               background_color = nil, -- set color for sign backgrounds. If nil, uses the default color set
               -- by the color scheme
            },
            customize = nil, -- customize the theme in any way you desire, see below what this
            -- configuration accepts
         }
      end,
   },
   {
      'catppuccin/nvim',
      name = 'catppuccin',
      priority = 1000,
      config = function()
         require('catppuccin').setup {
            flavour = 'auto', -- latte, frappe, macchiato, mocha
            background = { -- :h background
               light = 'latte',
               dark = 'mocha',
            },
            transparent_background = true, -- disables setting the background color.
            float = {
               transparent = false, -- enable transparent floating windows
               solid = false, -- use solid styling for floating windows, see |winborder|
            },
            show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
            term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
            dim_inactive = {
               enabled = false, -- dims the background color of inactive window
               shade = 'dark',
               percentage = 0.15, -- percentage of the shade to apply to the inactive window
            },
            no_italic = false, -- Force no italic
            no_bold = false, -- Force no bold
            no_underline = false, -- Force no underline
            styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
               comments = { 'italic' }, -- Change the style of comments
               conditionals = { 'italic' },
               loops = {},
               functions = {},
               keywords = {},
               strings = {},
               variables = {},
               numbers = {},
               booleans = {},
               properties = {},
               types = {},
               operators = {},
               -- miscs = {}, -- Uncomment to turn off hard-coded styles
            },
            lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
               virtual_text = {
                  errors = { 'italic' },
                  hints = { 'italic' },
                  warnings = { 'italic' },
                  information = { 'italic' },
                  ok = { 'italic' },
               },
               underlines = {
                  errors = { 'underline' },
                  hints = { 'underline' },
                  warnings = { 'underline' },
                  information = { 'underline' },
                  ok = { 'underline' },
               },
               inlay_hints = {
                  background = true,
               },
            },
            color_overrides = {},
            custom_highlights = {},
            default_integrations = true,
            auto_integrations = false,
            integrations = {
               cmp = true,
               gitsigns = true,
               nvimtree = true,
               notify = false,
               mini = {
                  enabled = true,
                  indentscope_color = '',
               },
               -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
            },
         }
      end,
   },
}
