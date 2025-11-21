local window = require('src.utils.window')

local screen = {}

function screen.create_header(icon_path)
    local result = {
        y = 10
    }
    result.sprite = love.graphics.newImage(icon_path)
    result.x = window.get_center_x() - result.sprite:getWidth() / 2
    return result
end

return screen
