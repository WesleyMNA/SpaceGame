require('src.Util')
require('src.gui.GUIManager')
require('src.DataManager')

POINTS = 0
WINDOW_WIDTH = love.graphics.getWidth()
WINDOW_HEIGHT = love.graphics.getHeight()

local guiManager
local mainTheme = love.audio.newSource('sounds/main_theme.mp3', 'static')

function playMainTheme()
    if not mainTheme:isPlaying() then 
        love.audio.play(mainTheme)
    end
end

function love.load()
    if not love.filesystem.getInfo(FILE) then save() end
    load()
    guiManager = GUIManager:new()
end

function love.update(dt)
    playMainTheme()
    guiManager:update(dt)
end

function love.draw()
    guiManager:render()
end

