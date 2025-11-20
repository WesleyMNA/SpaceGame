require('src.gui.Confirm')

Shop = {}
Shop.__index = Shop

function Shop:new(background, manager)
    local this = {
        class = 'Shop',

        background = background,
        manager= manager,

        errorSound = love.audio.newSource('sounds/gui/error.wav', 'static'),
        priceColor = {0, 255, 0},
        confirmation = false,

        currentShip = 1,
        ships = {}
    }

    this.header = createHeader('sprites/gui/headers/shop.png')
    this.confirm = Confirm:new(this)

    this.shipX = (WINDOW_WIDTH / 2) - 32
    this.shipY = 100

    setmetatable(this, self)

    this.numberOfShips = 0
    this:getShips()

    local backwardIcon = 'sprites/gui/selection/backward.png'
    local buttonY = 50
    this.backwardButton = Button:new(100, buttonY, backwardIcon)
    this.backwardButton.changeShip = function()
        if this.currentShip <= 1 then
            this.currentShip = this.numberOfShips
        else
            this.currentShip = this.currentShip - 1
        end
    end

    local confirmIcon = 'sprites/gui/selection/table.png'
    this.confirmButton = Button:new(160, buttonY, confirmIcon)

    local forwardIcon = 'sprites/gui/selection/forward.png'
    local buttonX = 160 + WINDOW_WIDTH/2 + 10
    this.forwardButton = Button:new(buttonX, buttonY, forwardIcon)
    this.forwardButton.changeShip = function()
        if this.currentShip >= this.numberOfShips then
            this.currentShip = 1
        else
            this.currentShip = this.currentShip + 1
        end
    end

    local closeIcon = 'sprites/gui/buttons/close.png'
    local buttonX = WINDOW_WIDTH/2 + 25
    local buttonY = buttonY + 50 + 10
    this.closeButton = Button:new(buttonX, buttonY, closeIcon)

    local okIcon = 'sprites/gui/buttons/ok.png'
    local buttonX = WINDOW_WIDTH/2 - 75
    this.okButton = Button:new(buttonX, buttonY, okIcon)

    return this
end

function Shop:update(dt)
    if self.confirmation then
        self.confirm:update(dt)
    else
        if #self.ships > 0 then
            self.price = SHIPS_DATA[self.ships[self.currentShip].id].price
        end
        function love.mousepressed(x, y)
            if CURRENT_GUI ~= 'shop' or self.confirmation then return end

            if #self.ships > 0 then
                if self.backwardButton:is_clicked() then self.backwardButton:changeShip() end

                if self.forwardButton:is_clicked() then self.forwardButton:changeShip() end

                if self.okButton:is_clicked() then
                    if self.price <= POINTS then 
                        self.confirmation = true
                    else
                        self:purchaseError()
                    end
                end
            end

            if self.closeButton:is_clicked() then CURRENT_GUI = 'selection' end
        end
    end
end

function Shop:render()
    love.graphics.setColor(255, 255, 255, 0.3)
    love.graphics.draw(self.background)

    if self.confirmation then
        self.confirm:render()
    else
        self.backwardButton:render()
        self.confirmButton:render()

        love.graphics.draw(self.header.sprite, self.header.x, self.header.y)
        if #self.ships > 0 then
            love.graphics.setColor(self.priceColor)
            love.graphics.print('Current Points: '..POINTS)
            love.graphics.setColor(255, 255, 0)
            love.graphics.print('Price: '..self.price, 0, 15)
            love.graphics.setColor(255, 255, 255)
            love.graphics.draw(
                self.ships[self.currentShip].sprite,
                self.shipX, self.shipY
            )
        else
            love.graphics.print('You have bought every ship!', self.shipX-50, self.shipY)
        end
        self.forwardButton:render()
        self.okButton:render()
        self.closeButton:render()
    end
end

function Shop:getShips()
    for i=1,6 do
        if not SHIPS_DATA[i].activated then
            self.numberOfShips = self.numberOfShips + 1
            self.ships[self.numberOfShips] = {
                id = SHIPS_DATA[i].id,
                sprite = SHIPS_DATA[i].sprite
            }
        end
    end
end

function Shop:purchaseShip()
    local id = self.ships[self.currentShip].id
    SHIPS_DATA[id].activated = true
    POINTS = POINTS - self.price
    self.manager:reset_selection()
    self.manager:reset_shop()
end

function Shop:purchaseError() 
    self.priceColor = {255, 0, 0}
    love.audio.play(self.errorSound)
end