Button = {}
Button.__index = Button

function Button:new(x, y, icon_path, onclick)
    local this = {
        _x = x,
        _y = y,
        _icon = love.graphics.newImage(icon_path),
        _onclick = onclick or function()
            error("Button:onclick() is abstract and must be overridden")
        end
    }

    setmetatable(this, self)
    return this
end

function Button:draw()
    love.graphics.setColor(255, 255, 255, 1)
    love.graphics.draw(self._icon, self._x, self._y)
end

function Button:mousepressed(x, y)
    if self:is_clicked(x, y) then
        self:_onclick()
    end
end

function Button:is_clicked(x, y)
    return x > self._x and x < self._x + self._icon:getWidth() and
        y > self._y and y < self._y + self._icon:getHeight()
end
