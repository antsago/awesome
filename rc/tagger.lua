--[[
   Set up tags with names and layouts and so on
--]]

-- {{{ Required libraries
local awful     = require("awful")
local lain      = require("lain")
-- }}}



-- {{{
layouts = {
    awful.layout.suit.floating,
    lain.layout.uselesstile,
    lain.layout.uselesstile.left,
    lain.layout.uselesstile.top
}
-- }}}

-- {{{ Tags
tags = {
   names = { "一", "二", "三", "四", "五" },
   layout = { layouts[2], layouts[2], layouts[2], layouts[2], layouts[2] }
}
for s = 1, screen.count() do
   tags[s] = awful.tag(tags.names, s, tags.layout)
end
-- }}}
