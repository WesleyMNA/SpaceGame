Button = {}
Button.__index = Button

function Button:new(x, y, width, height, text)
    local this = {
        class = 'Button',

        x = x,
        y = y,
        width = width,
        height = height,
        text = text or ''
    }

    setmetatable(this, self)
    return this
end

function Button:render()
    love.graphics.setColor(255, 255, 255, 1)
    love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    love.graphics.print(self.text, (self.x+7), (self.y+2))
end

