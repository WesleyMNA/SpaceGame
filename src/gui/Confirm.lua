local window = require('src.utils.window')

Confirm = {}
Confirm.__index = Confirm

function Confirm:new(shop)
    local this = {
        class = 'Confirm',
        shop = shop,
        icon = love.graphics.newImage('sprites/gui/headers/purchase.png'),
    }
    this.ok_button = Button:new(
        window.get_center_x() - 100,
        window.get_center_y(),
        'sprites/gui/buttons/ok.png',
        function()
            this.shop:purchase_ship()
            this.shop.confirmation = false
        end
    )
    this.close_button = Button:new(
        window.get_center_x() + 50,
        window.get_center_y(),
        'sprites/gui/buttons/close.png',
        function()
            this.shop.confirmation = false
        end
    )

    setmetatable(this, self)
    return this
end

function Confirm:mousepressed(x, y)
    self.ok_button:mousepressed(x, y)
    self.close_button:mousepressed(x, y)
end

function Confirm:draw()
    love.graphics.setColor(255, 255, 255, 1)
    local iconX = window.get_center_x() - self.icon:getWidth() / 2
    local iconY = 50
    love.graphics.draw(self.icon, iconX, iconY)

    self.ok_button:draw()
    self.close_button:draw()
end
