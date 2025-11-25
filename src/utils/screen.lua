require('src.gui.drawable')
local window = require('src.utils.window')

local screen = {}

function screen.create_header(image_path)
    local image = love.graphics.newImage(image_path)
    return Drawable:new(
        screen.centralize_image_in_x(image),
        10,
        image
    )
end

function screen.centralize_image_in_x(a_image)
    return window.get_center_x() - a_image:getWidth() / 2
end

return screen
