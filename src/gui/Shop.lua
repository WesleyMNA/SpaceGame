Shop = {}
Shop.__index = Shop

function Shop:new(background, manager)
    local this = {
        class = 'Shop',

        background = background,
        manager= manager,
        currentShip = 1,
        ships = {}
    }

    this.shipX = (WINDOW_WIDTH / 2) - 32
    this.shipY = 100

    local numberOfShips = 0
    for i=1,6 do
        if not SHIPS_DATA[i].activated then
            numberOfShips = numberOfShips + 1
            this.ships[numberOfShips] = {
                id = SHIPS_DATA[i].id,
                sprite = SHIPS_DATA[i].sprite
            }
        end
    end

    local backwardIcon = love.graphics.newImage('sprites/gui/selection/backward.png')
    local buttonY = 50
    this.backwardButton = Button:new(100, buttonY, backwardIcon)
    this.backwardButton.changeShip = function()
        if this.currentShip <= 1 then
            this.currentShip = numberOfShips
        else
            this.currentShip = this.currentShip - 1
        end
    end

    local confirmIcon = love.graphics.newImage('sprites/gui/selection/table.png')
    this.confirmButton = Button:new(160, buttonY, confirmIcon)

    local forwardIcon = love.graphics.newImage('sprites/gui/selection/forward.png')
    local buttonX = 160 + WINDOW_WIDTH/2 + 10
    this.forwardButton = Button:new(buttonX, buttonY, forwardIcon)
    this.forwardButton.changeShip = function()
        if this.currentShip >= numberOfShips then
            this.currentShip = 1
        else
            this.currentShip = this.currentShip + 1
        end
    end

    local closeIcon = love.graphics.newImage('sprites/gui/buttons/close.png')
    local buttonX = WINDOW_WIDTH/2 - 75
    local buttonY = buttonY + confirmIcon:getHeight() + 10
    this.closeButton = Button:new(buttonX, buttonY, closeIcon)

    local okIcon = love.graphics.newImage('sprites/gui/buttons/ok.png')
    local buttonX = WINDOW_WIDTH/2 + 25
    this.okButton = Button:new(buttonX, buttonY, okIcon)

    setmetatable(this, self)
    return this
end

function Shop:update(dt)
    function love.mousepressed(x, y)
        if CURRENT_GUI ~= 'shop' then return end

        if isClikingOnButton(self.backwardButton) then
            self.backwardButton:changeShip()
        end

        if isClikingOnButton(self.forwardButton) then
            self.forwardButton:changeShip()
        end

        if isClikingOnButton(self.closeButton) then
            CURRENT_GUI = 'selection'
        end

        if isClikingOnButton(self.okButton) then
            local id = self.ships[self.currentShip].id
            SHIPS_DATA[id].activated = true
            self.manager:resetSelection()
        end
    end
end

function Shop:render()
    love.graphics.setColor(255, 255, 255, 0.3)
    love.graphics.draw(self.background)
    self.backwardButton:render()
    self.confirmButton:render()
    love.graphics.draw(
        self.ships[self.currentShip].sprite,
        self.shipX, self.shipY
    )
    self.forwardButton:render()
    self.okButton:render()
    self.closeButton:render()
end
