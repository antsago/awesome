--[[
                                     
     Scorpio Awesome WM config 3.5.4
     github.com/antsago

     Heavily inspired from:
     github.com/copycat-killer/awesome-copycats
     github.com/vincentbernat/awesome-configuration

--]]


--// Required libraries
local awful     = require("awful")
local beautiful = require("beautiful")
local naughty   = require("naughty")



--// Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end




--// Call other (rc) files
function run(name)
   local success
   local result

   local path = awful.util.getdir("config") .. "/rc/"
      .. name .. ".lua"


   -- Execute the file
   success, result = pcall(function() return dofile(path) end)

   --report the error
   if not success then
      naughty.notify({ title = "Error while executing " .. name,
		       text = "Got the following error:\n" .. result,
		       preset = naughty.config.presets.critical
		     })
      return print("E: error loading RC file '" .. name .. "': " .. result)
   end

   return result
end

--// Variable definitions

-- localization
os.setlocale(os.getenv("LANG"))

-- beautiful init
beautiful.init(awful.util.getdir("config") .. "/theme/theme.lua")

-- common
modkey     = "Mod4"
altkey     = "Mod1"
terminal   = "urxvtc" or "xterm"
editor     = os.getenv("EDITOR") or "nano" or "vi"
editor_cmd = terminal .. " -e " .. editor

-- user defined
browser    = "dwb"
browser2   = "iron"
gui_editor = "gvim"
graphics   = "gimp"





--// Autostart applications
run('autoStart')

--// Set up tags
run('tagger')

--// Wallpaper
run('wallpaper')

--// Menu
require("freedesktop/freedesktop")

--// Set up the widgets
run('widgets')

--// Set up the top bar
run('topBar')

--// Mouse / Key bindings
run('keys')

--// Rules
run('rules')

--// Signals
run('signals')
