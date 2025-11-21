Button = {}
Button.__index = Button

function Button:new(x, y, icon_path, onclick)
    local this = {
        class = 'Button',
        x = x,
        y = y,
        icon = love.graphics.newImage(icon_path),
        onclick = onclick or function()
            error("Button:onclick() is abstract and must be overridden")
        end
    }

    setmetatable(this, self)
    return this
end

function Button:draw()
    love.graphics.setColor(255, 255, 255, 1)
    love.graphics.draw(self.icon, self.x, self.y)
end

function Button:mousepressed(x, y)
    if self:is_clicked(x, y) then
        self:onclick()
    end
end

function Button:is_clicked(x, y)
    return x > self.x and x < self.x + self.icon:getWidth() and
        y > self.y and y < self.y + self.icon:getHeight()
end
