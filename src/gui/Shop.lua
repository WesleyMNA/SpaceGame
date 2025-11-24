require('src.gui.confirm')

local game = require('src.utils.game')
local screen = require('src.utils.screen')
local window = require('src.utils.window')

Shop = {}
Shop.__index = Shop

function Shop:new(manager)
    local close_ok_button_y = 243
    local this = {
        _manager = manager,
        _header = screen.create_header('sprites/gui/headers/hangar.png'),
        _error_sound = love.audio.newSource('sounds/gui/error.wav', 'static'),
        _price_color = { 0, 255, 0 },
        _confirmation = false,
        _number_of_ships = 0,
        _current_ship = 1,
        _ships = {},
    }

    local button_y = 50
    local buttonX = 160 + window.get_center_x() + 10
    this._buttons = {
        ok = Button:new(
            window.get_center_x() - 75,
            close_ok_button_y,
            'sprites/gui/buttons/ok.png',
            function()
                if #this._ships <= 0 then
                    return
                end
                if this.price <= POINTS then
                    this._confirmation = true
                else
                    this:purchase_error()
                end
            end
        ),
        close_button = Button:new(
            window.get_center_x() + 25,
            close_ok_button_y,
            'sprites/gui/buttons/close.png',
            function()
                this._manager:switch_gui('selection')
            end
        ),
        backward = Button:new(
            100,
            button_y,
            'sprites/gui/selection/backward.png',
            function()
                if #this._ships <= 0 then
                    return
                end
                if this._current_ship <= 1 then
                    this._current_ship = this._number_of_ships
                else
                    this._current_ship = this._current_ship - 1
                end
            end
        ),
        forward = Button:new(
            buttonX,
            button_y,
            'sprites/gui/selection/forward.png',
            function()
                if #this._ships <= 0 then
                    return
                end
                if this._current_ship >= this._number_of_ships then
                    this._current_ship = 1
                else
                    this._current_ship = this._current_ship + 1
                end
            end
        ),
        confirm = Button:new(
            160,
            button_y,
            'sprites/gui/selection/table.png',
            function()
            end
        ),
    }
    this._confirm = Confirm:new(this)
    this._ship_x = window.get_center_x() - 32
    this._ship_y = 100
    setmetatable(this, self)
    this:get_ships()
    return this
end

function Shop:update(dt)
    if not self._confirmation and #self._ships > 0 then
        self._price = SHIPS_DATA[self._ships[self._current_ship].id].price
    end
end

function Shop:mousepressed(x, y)
    if self._confirmation then
        self._confirm:mousepressed(x, y)
    end

    game.mousepressed(self._buttons, x, y)
end

function Shop:draw()
    if self._confirmation then
        self._confirm:draw()
    else
        game.draw(self._buttons)
        love.graphics.draw(self._header.sprite, self._header.x, self._header.y)
        self:print_shop_data()
    end
end

function Shop:print_shop_data()
    if #self._ships > 0 then
        love.graphics.setColor(self._price_color)
        love.graphics.print('Current Points: ' .. POINTS)
        love.graphics.setColor(255, 255, 0)
        love.graphics.print('Price: ' .. self._price, 0, 15)
        love.graphics.setColor(255, 255, 255)
        love.graphics.draw(
            self._ships[self._current_ship].sprite,
            self._ship_x,
            self._ship_y
        )
    else
        love.graphics.print('You have bought every ship!', self._ship_x - 50, self._ship_y)
    end
end

function Shop:get_ships()
    for i = 1, 6 do
        if not SHIPS_DATA[i].activated then
            self._number_of_ships = self._number_of_ships + 1
            self._ships[self._number_of_ships] = {
                id = SHIPS_DATA[i].id,
                sprite = SHIPS_DATA[i].sprite
            }
        end
    end
end

function Shop:purchase_ship()
    local id = self._ships[self._current_ship].id
    SHIPS_DATA[id].activated = true
    POINTS = POINTS - self._price
    self._manager:reset_selection()
    self._manager:reset_shop()
end

function Shop:purchase_error()
    self._price_color = { 255, 0, 0 }
    love.audio.play(self._error_sound)
end
