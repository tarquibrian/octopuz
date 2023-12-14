local util = require("octopuz.util")

local M = {}
-- d9ed92
---@class Palette
M.default = {
  none = "NONE",
    bg_dark = "#000000", --
    bg = "#000000", --
    bg_highlight = "#2f334d", --
    terminal_black = "#444a73", --
    fg = "#c3ccdc", --
    fg_dark = "#acb4c2", --
    fg_gutter = "#303635",
    dark3 = "#545c7e",
    comment = "#acb4c2", --
    dark5 = "#737aa2",
    blue0 = "#3e68d7", --
    blue = "#dde2eb", --
    cyan = "#ff5874", --
    blue1 = "#21c7a8", --
    blue2 = "#ff5874",
    blue5 = "#ff5874",
    blue6 = "#b4f9f8", --
    blue7 = "#394b70",
    purple = "#c792ea", --
    magenta2 = "#ff007c",
    magenta = "#c099ff", --
    orange = "#f78c6c", --
    yellow = "#ffc777", --
    green = "#d9ed92", --
    green1 = "#7fdbca", --
    green2 = "#41a6b5",
    teal = "#4fd6be", --
    red = "#ff5874", --
    red1 = "#c53b53", --
  git = { change = "#6183bb", add = "#449dab", delete = "#914c54" },
  gitSigns = {
    add = "#266d6a",
    change = "#536c9e",
    delete = "#b2555b",
  },
}

---@return ColorScheme
function M.setup(opts)
  opts = opts or {}
  local config = require("octopuz.config")

  local style = config.is_day() and config.options.light_style or config.options.style
  local palette = M[style] or {}
  if type(palette) == "function" then
    palette = palette()
  end

  -- Color Palette
  ---@class ColorScheme: Palette
  local colors = vim.tbl_deep_extend("force", vim.deepcopy(M.default), palette)

  util.bg = colors.bg
  util.day_brightness = config.options.day_brightness

  colors.diff = {
    add = util.darken(colors.green2, 0.15),
    delete = util.darken(colors.red1, 0.15),
    change = util.darken(colors.blue7, 0.15),
    text = colors.blue7,
  }

  colors.git.ignore = colors.dark3
  colors.black = util.darken(colors.bg, 0.8, "#000000")
  colors.border_highlight = util.darken(colors.blue1, 0.8)
  colors.border = colors.black

  -- Popups and statusline always get a dark background
  colors.bg_popup = colors.bg_dark
  colors.bg_statusline = colors.bg_dark

  -- Sidebar and Floats are configurable
  colors.bg_sidebar = config.options.styles.sidebars == "transparent" and colors.none
    or config.options.styles.sidebars == "dark" and colors.bg_dark
    or colors.bg

  colors.bg_float = config.options.styles.floats == "transparent" and colors.none
    or config.options.styles.floats == "dark" and colors.bg_dark
    or colors.bg

  colors.bg_visual = util.darken(colors.blue0, 0.4)
  colors.bg_search = colors.blue0
  colors.fg_sidebar = colors.fg_dark
  -- colors.fg_float = config.options.styles.floats == "dark" and colors.fg_dark or colors.fg
  colors.fg_float = colors.fg

  colors.error = colors.red1
  colors.warning = colors.yellow
  colors.info = colors.blue2
  colors.hint = colors.teal

  colors.delta = {
    add = util.darken(colors.green2, 0.45),
    delete = util.darken(colors.red1, 0.45),
  }

  config.options.on_colors(colors)
  if opts.transform and config.is_day() then
    util.invert_colors(colors)
  end

  return colors
end

return M
