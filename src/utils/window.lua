local window = {}

function window.get_width()
    return love.graphics.getWidth()
end

function window.get_height()
    return love.graphics.getHeight()
end

function window.get_center_x()
    return window.get_width() / 2
end

function window.get_center_y()
    return window.get_height() / 2
end

local tile = require('src.utils.tile')

function window.get_tiles_per_width()
    return window.get_width() / tile.size
end

function window.get_tiles_per_height()
    return window.get_height() / tile.size
end

return window
