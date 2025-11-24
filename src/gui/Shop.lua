require('src.gui.confirm')

local game = require('src.utils.game')
local screen = require('src.utils.screen')
local window = require('src.utils.window')

Shop = {}
Shop.__index = Shop

function Shop:new(manager)
    local close_ok_button_y = 243
    local this = {
        manager = manager,
        header = screen.create_header('sprites/gui/headers/hangar.png'),
        error_sound = love.audio.newSource('sounds/gui/error.wav', 'static'),
        price_color = { 0, 255, 0 },
        confirmation = false,
        number_of_ships = 0,
        current_ship = 1,
        ships = {},
    }

    local button_y = 50
    local buttonX = 160 + window.get_center_x() + 10
    this.buttons = {
        ok = Button:new(
            window.get_center_x() - 75,
            close_ok_button_y,
            'sprites/gui/buttons/ok.png',
            function()
                if #this.ships <= 0 then
                    return
                end
                if this.price <= POINTS then
                    this.confirmation = true
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
                this.manager:switch_gui('selection')
            end
        ),
        backward = Button:new(
            100,
            button_y,
            'sprites/gui/selection/backward.png',
            function()
                if #this.ships <= 0 then
                    return
                end
                if this.current_ship <= 1 then
                    this.current_ship = this.number_of_ships
                else
                    this.current_ship = this.current_ship - 1
                end
            end
        ),
        forward = Button:new(
            buttonX,
            button_y,
            'sprites/gui/selection/forward.png',
            function()
                if #this.ships <= 0 then
                    return
                end
                if this.current_ship >= this.number_of_ships then
                    this.current_ship = 1
                else
                    this.current_ship = this.current_ship + 1
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
    this.confirm = Confirm:new(this)
    this.ship_x = window.get_center_x() - 32
    this.ship_y = 100
    setmetatable(this, self)
    this:get_ships()
    return this
end

function Shop:update(dt)
    if not self.confirmation and #self.ships > 0 then
        self.price = SHIPS_DATA[self.ships[self.current_ship].id].price
    end
end

function Shop:mousepressed(x, y)
    if self.confirmation then
        self.confirm:mousepressed(x, y)
    end

    game.mousepressed(self.buttons, x, y)
end

function Shop:draw()
    if self.confirmation then
        self.confirm:draw()
    else
        game.draw(self.buttons)
        love.graphics.draw(self.header.sprite, self.header.x, self.header.y)
        self:print_shop_data()
    end
end

function Shop:print_shop_data()
    if #self.ships > 0 then
        love.graphics.setColor(self.price_color)
        love.graphics.print('Current Points: ' .. POINTS)
        love.graphics.setColor(255, 255, 0)
        love.graphics.print('Price: ' .. self.price, 0, 15)
        love.graphics.setColor(255, 255, 255)
        love.graphics.draw(
            self.ships[self.current_ship].sprite,
            self.ship_x, self.ship_y
        )
    else
        love.graphics.print('You have bought every ship!', self.ship_x - 50, self.ship_y)
    end
end

function Shop:get_ships()
    for i = 1, 6 do
        if not SHIPS_DATA[i].activated then
            self.number_of_ships = self.number_of_ships + 1
            self.ships[self.number_of_ships] = {
                id = SHIPS_DATA[i].id,
                sprite = SHIPS_DATA[i].sprite
            }
        end
    end
end

function Shop:purchase_ship()
    local id = self.ships[self.current_ship].id
    SHIPS_DATA[id].activated = true
    POINTS = POINTS - self.price
    self.manager:reset_selection()
    self.manager:reset_shop()
end

function Shop:purchase_error()
    self.price_color = { 255, 0, 0 }
    love.audio.play(self.error_sound)
end
