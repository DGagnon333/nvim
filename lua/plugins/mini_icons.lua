-- File: ~/.config/nvim/lua/plugins/mini_icons.lua

return {
  "echasnovski/mini.icons",
  version = "*",
  config = function()
    require("mini.icons").setup({
      -- Your configuration here
      -- You can customize the icons as per your preference
    })
  end,
}

