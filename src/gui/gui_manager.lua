require('src.Map')
require('src.gui.Menu')
require('src.gui.Shop')
require('src.gui.pause')
require('src.gui.game_over')
require('src.gui.Selection')

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
        menu = Menu:new(this.background),
        pause = Pause:new(this.background),
        gameOver = GameOver:new(this.background, this),
        selection = Selection:new(this.background, this),
        shop = Shop:new(this.background, this)
    }

    setmetatable(this, self)
    return this
end

function GUIManager:update(dt)
    self.guis[CURRENT_GUI]:update(dt)
end

function GUIManager:render()
    self.guis[CURRENT_GUI]:render()
end

function GUIManager:create_map()
    local ship = self.guis.selection:getCurrentShipId()
    self.guis.map = Map:new(self.background, ship)
end

function GUIManager:reset_selection()
    self.guis.selection = Selection:new(self.background, self)
end

function GUIManager:reset_shop()
    self.guis.shop = Shop:new(self.background, self)
end
