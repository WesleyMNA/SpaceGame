local game = require('src.utils.game')
local window = require('src.utils.window')

Confirm = {}
Confirm.__index = Confirm

function Confirm:new(shop)
    local this = {
        _shop = shop,
        _icon = love.graphics.newImage('sprites/gui/headers/purchase.png'),
    }
    this._buttons = {
        ok = Button:new(
            window.get_center_x() - 100,
            window.get_center_y(),
            'sprites/gui/buttons/ok.png',
            function()
                this._shop:purchase_ship()
                this._shop.confirmation = false
            end
        ),
        close = Button:new(
            window.get_center_x() + 50,
            window.get_center_y(),
            'sprites/gui/buttons/close.png',
            function()
                this._shop.confirmation = false
            end
        )
    }

    setmetatable(this, self)
    return this
end

function Confirm:mousepressed(x, y)
    game.mousepressed(self._buttons, x, y)
end

function Confirm:draw()
    love.graphics.setColor(255, 255, 255, 1)
    local iconX = window.get_center_x() - self._icon:getWidth() / 2
    local iconY = 50
    love.graphics.draw(self._icon, iconX, iconY)

    game.draw(self._buttons)
end
