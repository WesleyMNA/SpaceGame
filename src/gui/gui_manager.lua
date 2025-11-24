require('src.Map')
require('src.gui.menu')
require('src.gui.shop')
require('src.gui.pause')
require('src.gui.game_over')
require('src.gui.selection')

local window = require('src.utils.window')
local tile = require('src.utils.tile')

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
        _current = 'menu',
        _background = create_background(window.get_tiles_per_width(), window.get_tiles_per_height())
    }

    this._guis = {
        menu = Menu:new(this),
        pause = Pause:new(this),
        gameOver = GameOver:new(this),
        selection = Selection:new(this),
        shop = Shop:new(this)
    }

    setmetatable(this, self)
    return this
end

function GUIManager:update(dt)
    if self:_get_current().update then
        self:_get_current():update(dt)
    end
end

function GUIManager:_get_current()
    return self._guis[self._current]
end

function GUIManager:draw()
    love.graphics.setColor(255, 255, 255, 0.3)
    love.graphics.draw(self._background)

    if self:_get_current().draw then
        self:_get_current():draw()
    end
end

function GUIManager:mousepressed(x, y)
    self:_get_current():mousepressed(x, y)
end

function GUIManager:switch_gui(new_gui)
    self._current = new_gui
end

function GUIManager:create_map()
    local ship = self._guis.selection:get_current_ship_id()
    self._guis.map = Map:new(ship, self)
    self:switch_gui('map')
end

function GUIManager:reset_selection()
    self._guis.selection = Selection:new(self)
end

function GUIManager:reset_shop()
    self._guis.shop = Shop:new(self)
end
