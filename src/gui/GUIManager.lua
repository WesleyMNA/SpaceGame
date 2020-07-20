require('src.Map')
require('src.gui.Menu')
require('src.gui.Pause')
require('src.gui.GameOver')
require('src.gui.Selection')

CURRENT_GUI = 'menu'

GUIManager = {}
GUIManager.__index = GUIManager

function GUIManager:new()
    local this = {
        class = 'GUIManager'
    }

    this.guis = {
        menu = Menu:new(),
        pause = Pause:new(),
        gameOver = GameOver:new(this),
        selection = Selection:new(this)
    }

    setmetatable(this, self)
    this:createMap()
    return this
end

function GUIManager:update(dt)
    self.guis[CURRENT_GUI]:update(dt)
end

function GUIManager:render()
    self.guis[CURRENT_GUI]:render()
end

function GUIManager:createMap()
    local randomNumber = math.random(9)
    local ship = self.guis.selection.currentShip
    self.guis.map = Map:new(randomNumber, ship)
end
