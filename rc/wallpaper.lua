--[[
   Set up the wallpaper
--]]


-- {{{ Required libraries
local beautiful = require("beautiful")
local gears     = require("gears")
-- }}}

--{{{ Wallpaper
-- code adapted from https://wiki.archlinux.org/index.php/awesome#Random_Background_Image
-- scan directory, and optionally filter outputs
function scandir(directory, filter)
    local i, t, popen = 0, {}, io.popen
    if not filter then
        filter = function(s) return true end
    end
    for filename in popen('ls -a "'..directory..'"'):lines() do
        if filter(filename) then
            i = i + 1
            t[i] = filename
        end
    end
    return t
end

-- configuration - edit to your liking
wp_timeout  = 300 --every 5 minutes
wp_path = beautiful.wallpaper_dir
wp_filter = function(s) return string.match(s,"%.png$") or string.match(s,"%.jpg$") end
wp_files = scandir(wp_path, wp_filter)
wp_index = math.random(1, #wp_files)
 
-- setup the timer
wp_timer = timer { timeout = 0} --initial random wallpaper
wp_timer:connect_signal("timeout", function()
 
  -- set wallpaper to current index for all screens
  for s = 1, screen.count() do
    gears.wallpaper.maximized(wp_path ..
	 wp_files[wp_index], s, true)
  end
 
  -- stop the timer (we don't need multiple instances running at the same time)
  wp_timer:stop()
 
  -- get next random index
  wp_index = math.random( 1, #wp_files)
 
  --restart the timer
  wp_timer.timeout = wp_timeout
  wp_timer:start()
end)
 
-- initial start when rc.lua is first run
wp_timer:start()

-- }}}
