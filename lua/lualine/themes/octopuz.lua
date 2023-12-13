local colors = require("octopuz.colors").setup({ transform = true })
local config = require("octopuz.config").options

local octopuz = {}

octopuz.normal = {
  a = { bg = "#4fd6be", fg = colors.black },
  b = { bg = colors.fg_gutter, fg = colors.blue },
  c = { bg = "#000000", fg = colors.fg_sidebar },
}

octopuz.insert = {
  a = { bg = "#ff5874", fg = colors.black },
  b = { bg = colors.fg_gutter, fg = "#ff5874" },
  c = { bg = "#000000", fg = colors.fg_sidebar },
}

octopuz.command = {
  a = { bg = colors.yellow, fg = colors.black },
  b = { bg = colors.fg_gutter, fg = colors.yellow },
}

octopuz.visual = {
  a = { bg = "#ffc777", fg = colors.black },
  b = { bg = colors.fg_gutter, fg = "#ffc777" },
  c = { bg = "#000000", fg = colors.fg_sidebar },
}

octopuz.replace = {
  a = { bg = colors.red, fg = colors.black },
  b = { bg = colors.fg_gutter, fg = colors.red },
  c = { bg = "#000000", fg = colors.fg_sidebar },
}

octopuz.terminal = {
  a = {bg = colors.green1, fg = colors.black },
  b = {bg = colors.fg_gutter, fg=colors.green1 },
  c = { bg = "#000000", fg = colors.fg_sidebar },
}

octopuz.inactive = {
  a = { bg = colors.bg_statusline, fg = colors.blue },
  b = { bg = colors.bg_statusline, fg = colors.fg_gutter, gui = "bold" },
  c = { bg = "#000000", fg = colors.fg_gutter },
}

if config.lualine_bold then
  for _, mode in pairs(octopuz) do
    mode.a.gui = "bold"
  end
end

return octopuz
