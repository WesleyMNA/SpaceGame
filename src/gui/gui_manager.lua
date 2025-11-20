require('src.Map')
require('src.gui.Menu')
require('src.gui.Shop')
require('src.gui.Pause')
require('src.gui.GameOver')
require('src.gui.Selection')

CURRENT_GUI = 'menu'

GUIManager = {}
GUIManager.__index = GUIManager

local randomNumber = math.random(9)

function GUIManager:new()
    local this = {
        class = 'GUIManager',

        tile = love.graphics.newImage('sprites/map/Space_Stars'..randomNumber..'.png'),
        mapWidth = math.floor(WINDOW_WIDTH / 64),
        mapHeight = math.floor(WINDOW_HEIGHT / 64),
    }

    this.background = love.graphics.newSpriteBatch(this.tile, this.mapWidth * this.mapHeight)
    for y = 0, this.mapHeight do
        for x = 0, this.mapWidth do
            this.background:add(x * 64, y * 64)
        end
    end

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

function GUIManager:createMap()
    local ship = self.guis.selection:getCurrentShipId()
    self.guis.map = Map:new(self.background, ship)
end

function GUIManager:resetSelection()
    self.guis.selection = Selection:new(self.background, self)
end

function GUIManager:resetShop()
    self.guis.shop = Shop:new(self.background, self)
end
