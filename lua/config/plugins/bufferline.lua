return {
  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = 'VeryLazy',
    keys = {
      { "<C-h>",      "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<C-l>",      "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "<leader>x",  "<cmd>bdelete<cr>",             desc = "Close Buffer" },
      { "<leader>bp", "<cmd>BufferLinePick<cr>",      desc = "Buffer Pick (Jump)" },
    },
    config = function()
      local bufferline = require 'bufferline'
      bufferline.setup({
        options = {
          numbers = "ordinal",
          separator_style = "slant",
          always_show_bufferline = true,
          show_buffer_close_icons = false,
          show_close_icon = false,
          show_buffer_icons = true,
          diagnostics = "nvim_lsp",
          offsets = {
            {
              filetype = "snacks_layout_box",
              text = "Explorer",
              text_align = "left",
              separator = true,
            }
          },
          close_command = function(n) Snacks.bufdelete(n) end,
          right_mouse_command = function(n) Snacks.bufdelete(n) end,
        },
      })
    end
  }
}
