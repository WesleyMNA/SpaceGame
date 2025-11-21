require('src.Util')
require('src.gui.gui_manager')
require('src.DataManager')

POINTS = 0
TILE_SIZE = 64
WINDOW_WIDTH = love.graphics.getWidth()
WINDOW_HEIGHT = love.graphics.getHeight()

local gui_manager
local mainTheme = love.audio.newSource('sounds/main_theme.mp3', 'static')

local function start_main_theme()
    if not mainTheme:isPlaying() then
        love.audio.play(mainTheme)
    end
end

function love.load()
    if not love.filesystem.getInfo(FILE) then save() end
    load()
    gui_manager = GUIManager:new()
end

function love.update(dt)
    start_main_theme()
    gui_manager:update(dt)
end

function love.draw()
    gui_manager:render()
end

function love.mousepressed(x, y)
    gui_manager:mousepressed(x, y)
end
