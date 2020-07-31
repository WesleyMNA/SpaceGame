Confirm = {}
Confirm.__index = Confirm

function Confirm:new(shop)
    local this = {
        class = 'Confirm',

        icon = love.graphics.newImage('sprites/gui/headers/purchase.png'),
        shop = shop
    }

    local okIcon = love.graphics.newImage('sprites/gui/buttons/ok.png')
    local okX = (WINDOW_WIDTH / 2) - 100
    local okY = WINDOW_HEIGHT / 2
    this.okButton = Button:new(okX, okY, okIcon)

    local closeIcon = love.graphics.newImage('sprites/gui/buttons/close.png')
    local closeX = WINDOW_WIDTH / 2 + 50
    local closeY = WINDOW_HEIGHT / 2
    this.closeButton = Button:new(closeX, closeY, closeIcon)

    setmetatable(this, self)
    return this
end

function Confirm:update(dt)
    function love.mousepressed(x, y)
        if self.okButton:isClicked() then
            self.shop:purchaseShip()
            self.shop.confirmation = false
        end

        if self.closeButton:isClicked() then self.shop.confirmation = false end
    end
end

function Confirm:render()
    love.graphics.setColor(255, 255, 255, 1)
    local iconX = WINDOW_WIDTH/2 - self.icon:getWidth()/2
    local iconY = 50
    love.graphics.draw(self.icon, iconX, iconY)

    self.okButton:render()
    self.closeButton:render()
end
