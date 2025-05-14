local notify = require("notify")

notify.setup({
  background_colour = "NotifyBackground",
  fps = 30,
  icons = {
    DEBUG = "",
    ERROR = "",
    INFO = "",
    TRACE = "✎",
    WARN = ""
  },
  level = 2,
  minimum_width = 20,
  max_width = 42,
  render = "wrapped-compact",
  stages = "static",
  time_formats = {
    notification = "%T",
    notification_history = "%FT%T"
  },
  timeout = 5000,
  top_down = false,
})

vim.notify = notify
