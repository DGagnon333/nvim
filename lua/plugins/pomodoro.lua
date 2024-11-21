return {
  "epwalsh/pomo.nvim",
  version = "*",  -- Recommended, use the latest release
  lazy = true,
  cmd = { "TimerStart", "TimerRepeat", "TimerSession", "TimerStop", "TimerHide", "TimerShow" },
  dependencies = {
    "rcarriga/nvim-notify", -- Optional, integrates with notify
  },
  opts = {
    display = { 
      open_cmd = nil, -- Prevent opening a floating window for the timer
    },
    timers = {
      pomodoro = { duration = 25 * 60 }, -- Default Pomodoro timer duration
      short_break = { duration = 5 * 60 }, -- Short break duration
      long_break = { duration = 15 * 60 }, -- Long break duration
    },
    persistence = {
      enabled = true, -- Enable persistence across sessions
      location = vim.fn.stdpath("data") .. "/pomo_session.json", -- Path to save the session
    },
  },
  config = function(_, opts)
    local pomo = require("pomo")
    pomo.setup(opts)

    -- Automatically enable the Telescope extension
    require("telescope").load_extension("pomodori")
  end,
  keys = {
    {
      "<leader>ps",
      function()
        vim.api.nvim_feedkeys(":TimerStart ", "n", false)
      end,
      desc = "Start a Timer with Duration",
    },
    {
      "<leader>pb",
      function()
        require("pomo").start_timer(5 * 60, "Short Break")
      end,
      desc = "Start a Short Break Timer",
    },
    {
      "<leader>pl",
      function()
        require("pomo").start_timer(15 * 60, "Long Break")
      end,
      desc = "Start a Long Break Timer",
    },
    {
      "<leader>pe",
      function()
        require("pomo").stop_timer()
      end,
      desc = "Stop the Timer",
    },
    {
      "<leader>pt",
      function()
        require("telescope").extensions.pomodori.timers()
      end,
      desc = "Manage Timers with Telescope",
    },
    {
      "<leader>ph",
      function()
        require("pomo").hide_timer(require("pomo").get_latest())
      end,
      desc = "Hide the Most Recent Timer",
    },
    {
      "<leader>pH",
      function()
        require("pomo").show_timer(require("pomo").get_latest())
      end,
      desc = "Show the Most Recent Timer",
    },
  },
}

