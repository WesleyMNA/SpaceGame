Button = {}
Button.__index = Button

function Button:new(x, y, icon_path)
    local this = {
        class = 'Button',
        x = x,
        y = y,
        icon = love.graphics.newImage(icon_path),
    }

    setmetatable(this, self)
    return this
end

function Button:render()
    love.graphics.setColor(255, 255, 255, 1)
    love.graphics.draw(self.icon, self.x, self.y)
end

function Button:is_clicked()
    local m_x, m_y = love.mouse.getPosition()
    return m_x > self.x and m_x < self.x + self.icon:getWidth() and
        m_y > self.y and m_y < self.y + self.icon:getHeight()
end
