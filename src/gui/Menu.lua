require('src.gui.Button')

Menu = {}
Menu.__index = Menu

function Menu:new()
    local this = {
        class = 'Menu',

        icon = love.graphics.newImage('sprites/gui/icon.png')
    }

    this.button = Button:new(
        (WINDOW_WIDTH / 2) - 26,
        (WINDOW_HEIGHT / 2) - 8,
        50, 20, 'Start'
    )
    this.button.update = function(dt)
        if love.mouse.isDown(1) and isClikingOnButton(this.button) then
            CURRENT_GUI = 'selection'
        end
    end

    this.selection = Selection:new()

    setmetatable(this, self)
    return this
end

function Menu:update(dt)
    self.button.update(dt)
end

function Menu:render()
    love.graphics.setColor(255, 255, 255, 1)
    love.graphics.draw(
        self.icon,
        (WINDOW_WIDTH / 2) - 32,
        100
    )
    self.button:render()
end

