--[[
	File to autostart applications
--]]

-- {{{ Required libraries
local awful     = require("awful")
-- }}}


-- {{{ Execute a command
function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
     findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end
-- }}}


-- {{{ Applications/Commands to run
run_once("urxvtd")
--run_once("unclutter")
--run_once("compton")
-- }}}
