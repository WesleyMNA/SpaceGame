require('src.gui.button')

local game = require('src.utils.game')
local screen = require('src.utils.screen')
local window = require('src.utils.window')

Selection = {}
Selection.__index = Selection

function Selection:new(manager)
    local close_ok_button_y = 243
    local this = {
        class = 'Selection',
        manager = manager,
        header = screen.create_header('sprites/gui/headers/hangar.png'),
        current_ship = 1,
        ships = {},
        number_of_ships = 0,
    }
    local button_y = 50

    this.buttons = {
        close_button = Button:new(
            window.get_center_x() + 25,
            close_ok_button_y,
            'sprites/gui/buttons/close.png',
            function()
                CURRENT_GUI = 'menu'
            end
        ),
        shop_button = Button:new(
            window.get_width() - 50,
            window.get_height() - 50,
            'sprites/gui/selection/shop.png',
            function()
                CURRENT_GUI = 'shop'
            end
        ),
        ok_button = Button:new(
            window.get_center_x() - 75,
            close_ok_button_y,
            'sprites/gui/buttons/ok.png',
            function()
                this.manager:create_map()
                CURRENT_GUI = 'map'
            end
        ),
        backward_button = Button:new(
            100,
            button_y,
            'sprites/gui/selection/backward.png',
            function()
                if this.current_ship <= 1 then
                    this.current_ship = this.number_of_ships
                else
                    this.current_ship = this.current_ship - 1
                end
            end
        ),
        forward_button = Button:new(
            window.get_center_x() + 170,
            button_y,
            'sprites/gui/selection/forward.png',
            function()
                if this.current_ship >= this.number_of_ships then
                    this.current_ship = 1
                else
                    this.current_ship = this.current_ship + 1
                end
            end
        ),
        table_button = Button:new(
            160,
            button_y,
            'sprites/gui/selection/table.png'
        )
    }

    setmetatable(this, self)
    this:get_activated_ships()
    return this
end

function Selection:update(dt)
    save()
end

function Selection:mousepressed(x, y)
    game.mousepressed(self.buttons, x, y)
end

function Selection:draw()
    game.draw(self.buttons)
    love.graphics.draw(self.header.sprite, self.header.x, self.header.y)
    local shipX = (window.get_center_x()) - 32
    local shipY = 100
    love.graphics.draw(
        self.ships[self.current_ship].sprite, shipX, shipY
    )
end

function Selection:get_activated_ships()
    for i = 1, 6 do
        if SHIPS_DATA[i].activated then
            self.number_of_ships = self.number_of_ships + 1
            self.ships[self.number_of_ships] = {
                id = SHIPS_DATA[i].id,
                sprite = SHIPS_DATA[i].sprite
            }
        end
    end
end

function Selection:get_current_ship_id()
    return self.ships[self.current_ship].id
end
