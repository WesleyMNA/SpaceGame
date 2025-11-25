Drawable = {}
Drawable.__index = Drawable

function Drawable:new(x, y, image)
    local this = {
        _x = x,
        _y = y,
        _image = image,
    }
    setmetatable(this, self)
    return this
end

function Drawable:draw()
    love.graphics.setColor(255, 255, 255, 1)
    love.graphics.draw(self._image, self._x, self._y)
end
