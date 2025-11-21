require('src.Map')
require('src.gui.menu')
require('src.gui.shop')
require('src.gui.pause')
require('src.gui.game_over')
require('src.gui.selection')

local window = require('src.utils.window')
local tile = require('src.utils.tile')
CURRENT_GUI = 'menu'

GUIManager = {}
GUIManager.__index = GUIManager

local function create_background(width, height)
    local background_id = math.random(9)
    local background_tile = love.graphics.newImage('sprites/map/Space_Stars' .. background_id .. '.png')
    local result = love.graphics.newSpriteBatch(background_tile, width * height)
    for y = 0, height do
        for x = 0, width do
            result:add(tile.to_tile_size(x), tile.to_tile_size(y))
        end
    end
    return result
end

function GUIManager:new()
    local this = {
        class = 'GUIManager',
        background = create_background(window.get_tiles_per_width(), window.get_tiles_per_height())
    }

    this.guis = {
        menu = Menu:new(),
        pause = Pause:new(),
        gameOver = GameOver:new(this),
        selection = Selection:new(this),
        shop = Shop:new(this)
    }

    setmetatable(this, self)
    return this
end

function GUIManager:update(dt)
    if self.guis[CURRENT_GUI].update then
        self.guis[CURRENT_GUI]:update(dt)
    end
end

function GUIManager:render()
    love.graphics.setColor(255, 255, 255, 0.3)
    love.graphics.draw(self.background)

    self.guis[CURRENT_GUI]:render()
end

function GUIManager:mousepressed(x, y)
    self.guis[CURRENT_GUI]:mousepressed(x, y)
end

function GUIManager:create_map()
    local ship = self.guis.selection:get_current_ship_id()
    self.guis.map = Map:new(ship)
end

function GUIManager:reset_selection()
    self.guis.selection = Selection:new(self)
end

function GUIManager:reset_shop()
    self.guis.shop = Shop:new(self)
end
