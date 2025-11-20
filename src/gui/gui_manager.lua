require('src.Map')
require('src.gui.Menu')
require('src.gui.Shop')
require('src.gui.Pause')
require('src.gui.GameOver')
require('src.gui.Selection')

CURRENT_GUI = 'menu'

GUIManager = {}
GUIManager.__index = GUIManager

local function create_background(map_width, map_height)
    local randomNumber = math.random(9)
    local background_tile = love.graphics.newImage('sprites/map/Space_Stars' .. randomNumber .. '.png')
    local background = love.graphics.newSpriteBatch(background_tile, map_width * map_height)
    for y = 0, map_height do
        for x = 0, map_width do
            background:add(x * TILE_SIZE, y * TILE_SIZE)
        end
    end
    return background
end

function GUIManager:new()
    local this = {
        class = 'GUIManager',

        mapWidth = math.floor(WINDOW_WIDTH / TILE_SIZE),
        mapHeight = math.floor(WINDOW_HEIGHT / TILE_SIZE),
    }

    this.background = create_background(this.mapWidth, this.mapHeight)

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
