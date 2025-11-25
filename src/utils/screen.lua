local window = require('src.utils.window')

local screen = {}

function screen.create_header(icon_path)
    local result = {
        y = 10
    }
    result.image = love.graphics.newImage(icon_path)
    result.x = screen.centralize_image_in_x(result.image)
    return result
end

function screen.centralize_image_in_x(a_image)
    return window.get_center_x() - a_image:getWidth() / 2
end

return screen
