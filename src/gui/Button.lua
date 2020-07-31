Button = {}
Button.__index = Button

function Button:new(x, y, icon)
    local this = {
        class = 'Button',
        x = x,
        y = y,
        icon = icon,
        width = icon:getWidth(),
        height = icon:getHeight()
    }

    setmetatable(this, self)
    return this
end

function Button:render()
    love.graphics.setColor(255, 255, 255, 1)
    love.graphics.draw(self.icon, self.x, self.y)
end

function Button:isClicked()
    local mouseX, mouseY = love.mouse.getPosition()
    local bool = mouseX > self.x and mouseX < self.x + self.width and
            mouseY > self.y and mouseY < self.y + self.height

    return bool
end

