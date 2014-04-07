--[[
   Set up wibox
--]]


-- {{{ Required libraries
local lain      = require("lain")
local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
-- }}}



-- {{{ Wibox
markup = lain.util.markup
gray   = "#9E9C9A"

-- Textclock
mytextclock = awful.widget.textclock(" %H:%M ")

-- Calendar
lain.widgets.calendar:attach(mytextclock)

--[[ Mail IMAP check
-- commented because it needs to be set before use
mailwidget = lain.widgets.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        mail  = ""
        count = ""

        if mailcount > 0 then
            mail = "Arch "
            count = mailcount .. " "
        end

        widget:set_markup(markup(gray, mail) .. count)
    end
})
]]--

-- MPD
mpdwidget = lain.widgets.mpd({
    settings = function()
        artist = mpd_now.artist .. " "
        title  = mpd_now.title  .. "  "

        if mpd_now.state == "pause" then
            artist = "mpd "
            title  = "paused  "
        elseif mpd_now.state == "stop" then
            artist = ""
            title  = ""
        end

        widget:set_markup(markup(gray, artist) .. title)
    end
})

-- /home fs
fshome = lain.widgets.fs({
    partition = "/home",
    settings  = function()
        fs_header = ""
        fs_p      = ""

        if fs_now.used >= 90 then
            fs_header = " Hdd "
            fs_p      = fs_now.used
        end

        widget:set_markup(markup(gray, fs_header) .. fs_p)
    end
})

-- Battery
batwidget = lain.widgets.bat({
    settings = function()
        bat_header = " Bat "
        bat_p      = bat_now.perc .. " "

        if bat_now.status == "Not present" then
            bat_header = ""
            bat_p      = ""
        end

        widget:set_markup(markup(gray, bat_header) .. bat_p)
    end
})

-- ALSA volume
volumewidget = lain.widgets.alsa({
    settings = function()
        header = " Vol "
        level  = volume_now.level

        if volume_now.status == "off" then
            level = level .. "M "
        else
            level = level .. " "
        end

        widget:set_markup(markup(gray, header) .. level)
    end
})

-- Weather
yawn = lain.widgets.yawn(123456,
{
    settings = function()
        widget:set_markup(" " .. units .. " ")
    end
})
