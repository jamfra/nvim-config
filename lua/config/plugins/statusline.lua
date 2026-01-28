return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local statusline = require 'lualine'
      statusline.setup({})
    end
  }
}
