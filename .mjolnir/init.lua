local application = require "mjolnir.application"
local fnutils = require "mjolnir.fnutils"
local geometry = require "mjolnir.geometry"
local hotkey = require "mjolnir.hotkey"
local screen = require "mjolnir.screen"
local window = require "mjolnir.window"


local mash = {"alt"}
local spectacle = {"cmd", "alt"}
local spectacleshift = {"cmd", "alt", "shift"}

-- Global Keyboard Shortcuts
hotkey.bind(mash, 'F', function() application.launchorfocus('Finder') end)
hotkey.bind(mash, 'C', function() application.launchorfocus('Google Chrome') end)
hotkey.bind(mash, 'I', function() application.launchorfocus('iTerm') end)
hotkey.bind(mash, 'P', function() application.launchorfocus('Pycharm') end)
hotkey.bind(mash, 'M', function() application.launchorfocus('iTunes') end)
hotkey.bind(mash, 'S', function() application.launchorfocus('Slack') end)
hotkey.bind(mash, 'T', function() application.launchorfocus('Telegram') end)
hotkey.bind(mash, 'L', function() application.launchorfocus('Spark') end)
hotkey.bind(mash, '1', function() application.launchorfocus('1Password 7') end)
hotkey.bind(mash, 'Q', function() application.launchorfocus('Quiver') end)

-- Move Windows
function moveTo(win, x, y, h, w)
  local rect = geometry.rect(x, y, h, w)
  win:movetounit(rect)
end

	

hotkey.bind(spectacle, "J", function()
    moveTo(window.focusedwindow(), 0, 0.5, 1, 0.5)
end)

hotkey.bind(spectacle, "K", function()
    moveTo(window.focusedwindow(), 0, 0, 1, 0.5)
end)

hotkey.bind(spectacle, "L", function()
    moveTo(window.focusedwindow(), 0.5, 0, 0.5, 1)
end)

-- Full screen
hotkey.bind(spectacle, "F", function()
    local win = window.focusedwindow():maximize()
end)
