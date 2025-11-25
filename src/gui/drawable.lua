Drawable = {}
Drawable.__index = Drawable

function Drawable:new(image, x, y)
    local this = {
        _image = image,
        _x = x,
        _y = y
    }
    setmetatable(this, self)
    return this
end

function Drawable:draw()
    love.graphics.setColor(255, 255, 255, 1)
    love.graphics.draw(self._image, self._x, self._y)
end
