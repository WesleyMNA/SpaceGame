require('src.gui.Menu')
require('src.Map')
require('src.CreateCollisionClasses')

POINTS = 0
WINDOW_WIDTH = love.graphics.getWidth()
WINDOW_HEIGHT = love.graphics.getHeight()
RUN = false

local wf = require 'libs.windfield'

local menu
local map
local world

local function loadGame()
    menu = Menu:new()
    world = wf.newWorld(0, 0, true)
    createCollisionClasses(world)

    map = Map:new(world)
end

function love.load()
    loadGame()
end

function love.update(dt)
    if RUN then
        world:update(dt)
        map:update(dt)
    else
        loadGame()
        menu:update(dt)
    end
end

function love.draw()
    if RUN then
--        world:draw()
        map:render()
    else
        menu:render()
    end
end
