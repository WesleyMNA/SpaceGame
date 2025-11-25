require('src.gui.drawable')

local game = require('src.utils.game')
local screen = require('src.utils.screen')
local window = require('src.utils.window')

local function create_icon()
    local image = love.graphics.newImage('sprites/gui/headers/purchase.png')
    return Drawable:new(
        screen.centralize_image_in_x(image),
        50,
        image
    )
end

Confirm = {}
Confirm.__index = Confirm

function Confirm:new(shop)
    local this = {
        _shop = shop,
        _icon = create_icon(),
    }
    this._buttons = {
        Button:new(
            window.get_center_x() - 100,
            window.get_center_y(),
            'sprites/gui/buttons/ok.png',
            function()
                this._shop:purchase_ship()
                this._shop.confirmation = false
            end
        ),
        Button:new(
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
    self._icon:draw()
    game.draw(self._buttons)
end
