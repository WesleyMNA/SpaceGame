require('src.gui.Button')

Selection = {}
Selection.__index = Selection

function Selection:new(manager)
    local this = {
        class = 'Selection',

        manager= manager,
        currentShip = 1,
        ships = {}
    }

    this.shipX = (WINDOW_WIDTH / 2) - 32
    this.shipY = 100

    local numberOfShips = 2
    for i=1,numberOfShips do
        this.ships[i] = love.graphics.newImage('sprites/player/ship'.. i ..'/ship.png')
    end

    this.leftButton = Button:new(140, 50, 50, WINDOW_HEIGHT/2, '<')
    this.leftButton.changeShip = function()
        if this.currentShip <= 1 then
            this.currentShip = numberOfShips
        else
            this.currentShip = this.currentShip - 1
        end
    end

    this.confirmButton = Button:new(200, 50, WINDOW_WIDTH/2, WINDOW_HEIGHT/2)

    this.rightButton = Button:new(610, 50, 50, WINDOW_HEIGHT/2, '>')
    this.rightButton.changeShip = function()
        if this.currentShip >= numberOfShips then
            this.currentShip = 1
        else
            this.currentShip = this.currentShip + 1
        end
    end

    setmetatable(this, self)
    return this
end

function Selection:update(dt)
    function love.mousepressed(x, y)
        if CURRENT_GUI ~= 'selection' then return end

        if isClikingOnButton(self.leftButton) then
            self.leftButton:changeShip()
        end

        if isClikingOnButton(self.confirmButton) then
            self.manager:createMap()
            CURRENT_GUI = 'map'
        end

        if isClikingOnButton(self.rightButton) then
            self.rightButton:changeShip()
        end
    end
end

function Selection:render()
    self.leftButton:render()
    self.confirmButton:render()
    love.graphics.draw(
        self.ships[self.currentShip],
        self.shipX, self.shipY
    )
    self.rightButton:render()
end
