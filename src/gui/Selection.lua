require('src.gui.button')

Selection = {}
Selection.__index = Selection

function Selection:new(background, manager)
    local this = {
        class = 'Selection',


        background = background,
        manager= manager,
        currentShip = 1,
        ships = {}
    }

    this.header = createHeader('sprites/gui/headers/hangar.png')

    setmetatable(this, self)

    this.numberOfShips = 0
    this:getActivatedShips()

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

    local tableIcon = 'sprites/gui/selection/table.png'
    this.tableButton = Button:new(160, buttonY, tableIcon)

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
    local buttonY = buttonY + 183 + 10
    this.closeButton = Button:new(buttonX, buttonY, closeIcon)

    local okIcon = 'sprites/gui/buttons/ok.png'
    local buttonX = WINDOW_WIDTH/2 - 75
    this.okButton = Button:new(buttonX, buttonY, okIcon)

    local shopIcon = 'sprites/gui/selection/shop.png'
    local buttonX = WINDOW_WIDTH - 50
    local buttonY = WINDOW_HEIGHT - 50
    this.shopButton = Button:new(buttonX, buttonY, shopIcon)

    return this
end

function Selection:update(dt)
    save()
    function love.mousepressed(x, y)
        if CURRENT_GUI ~= 'selection' then return end

        if self.backwardButton:is_clicked() then self.backwardButton:changeShip() end

        if self.okButton:is_clicked() then
            self.manager:create_map()
            CURRENT_GUI = 'map'
        end

        if self.closeButton:is_clicked() then CURRENT_GUI = 'menu' end

        if self.forwardButton:is_clicked() then self.forwardButton:changeShip() end

        if self.shopButton:is_clicked() then CURRENT_GUI = 'shop' end
    end
end

function Selection:render()
    love.graphics.setColor(255, 255, 255, 0.3)
    love.graphics.draw(self.background)
    self.backwardButton:render()
    self.tableButton:render()
    love.graphics.draw(self.header.sprite, self.header.x, self.header.y)
    local shipX = (WINDOW_WIDTH / 2) - 32
    local shipY = 100
    love.graphics.draw(
        self.ships[self.currentShip].sprite, shipX, shipY
    )
    self.forwardButton:render()
    self.okButton:render()
    self.closeButton:render()
    self.shopButton:render()
end

function Selection:getActivatedShips()
    for i=1,6 do
        if SHIPS_DATA[i].activated then
            self.numberOfShips = self.numberOfShips + 1
            self.ships[self.numberOfShips] = {
                id = SHIPS_DATA[i].id,
                sprite = SHIPS_DATA[i].sprite
            }
        end
    end
end

function Selection:getCurrentShipId()
    return self.ships[self.currentShip].id
end