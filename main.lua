require('src.Util')
require('src.gui.GUIManager')
require('src.DataManager')

POINTS = 10000000
WINDOW_WIDTH = love.graphics.getWidth()
WINDOW_HEIGHT = love.graphics.getHeight()

local guiManager

function love.load()
    if not love.filesystem.getInfo(FILE) then save() end
    load()
    guiManager = GUIManager:new()
end

function love.update(dt)
    guiManager:update(dt)
end

function love.draw()
    guiManager:render()
end
