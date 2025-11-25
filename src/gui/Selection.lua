require('src.gui.button')

local game = require('src.utils.game')
local screen = require('src.utils.screen')
local window = require('src.utils.window')

Selection = {}
Selection.__index = Selection

function Selection:new(manager)
    local close_ok_button_y = 243
    local this = {
        _manager = manager,
        _header = screen.create_header('sprites/gui/headers/hangar.png'),
        _current_ship = 1,
        _ships = {},
        _number_of_ships = 0,
    }
    local button_y = 50

    this._buttons = {
        close_button = Button:new(
            window.get_center_x() + 25,
            close_ok_button_y,
            'sprites/gui/buttons/close.png',
            function()
                this._manager:switch_gui('menu')
            end
        ),
        shop_button = Button:new(
            window.get_width() - 50,
            window.get_height() - 50,
            'sprites/gui/selection/shop.png',
            function()
                this._manager:switch_gui('shop')
            end
        ),
        ok_button = Button:new(
            window.get_center_x() - 75,
            close_ok_button_y,
            'sprites/gui/buttons/ok.png',
            function()
                this._manager:create_map()
            end
        ),
        backward_button = Button:new(
            100,
            button_y,
            'sprites/gui/selection/backward.png',
            function()
                if this._current_ship <= 1 then
                    this._current_ship = this._number_of_ships
                else
                    this._current_ship = this._current_ship - 1
                end
            end
        ),
        forward_button = Button:new(
            window.get_center_x() + 170,
            button_y,
            'sprites/gui/selection/forward.png',
            function()
                if this._current_ship >= this._number_of_ships then
                    this._current_ship = 1
                else
                    this._current_ship = this._current_ship + 1
                end
            end
        ),
    }
    this._table = Drawable:new(
        160,
        button_y,
        love.graphics.newImage('sprites/gui/selection/table.png')
    )
    setmetatable(this, self)
    this:get_activated_ships()
    return this
end

function Selection:update(dt)
    save()
end

function Selection:mousepressed(x, y)
    game.mousepressed(self._buttons, x, y)
end

function Selection:draw()
    game.draw(self._buttons)
    self._table:draw()
    self._header:draw()
    local shipX = (window.get_center_x()) - 32
    local shipY = 100
    love.graphics.draw(
        self._ships[self._current_ship].sprite, shipX, shipY
    )
end

function Selection:get_activated_ships()
    for i = 1, 6 do
        if SHIPS_DATA[i].activated then
            self._number_of_ships = self._number_of_ships + 1
            self._ships[self._number_of_ships] = {
                id = SHIPS_DATA[i].id,
                sprite = SHIPS_DATA[i].sprite
            }
        end
    end
end

function Selection:get_current_ship_id()
    return self._ships[self._current_ship].id
end
