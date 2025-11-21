local window = require('src.utils.window')

Confirm = {}
Confirm.__index = Confirm

function Confirm:new(shop)
    local this = {
        class = 'Confirm',
        shop = shop,
        icon = love.graphics.newImage('sprites/gui/headers/purchase.png'),
        ok_button = Button:new(
            window.get_center_x() - 100,
            window.get_center_y(),
            'sprites/gui/buttons/ok.png'
        ),
        close_button = Button:new(
            window.get_center_x() + 50,
            window.get_center_y(),
            'sprites/gui/buttons/close.png'
        ),
    }

    setmetatable(this, self)
    return this
end

function Confirm:mousepressed(x, y)
    if self.ok_button:is_clicked(x, y) then
        self.shop:purchaseShip()
        self.shop.confirmation = false
    end

    if self.close_button:is_clicked(x, y) then self.shop.confirmation = false end
end

function Confirm:render()
    love.graphics.setColor(255, 255, 255, 1)
    local iconX = window.get_center_x() - self.icon:getWidth() / 2
    local iconY = 50
    love.graphics.draw(self.icon, iconX, iconY)

    self.ok_button:render()
    self.close_button:render()
end
