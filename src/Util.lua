function renderLoop(objectList)
    for i, object in pairs(objectList) do
        object:render()
    end
end

function updateLoop(dt, objectList)
    for i, object in pairs(objectList) do
        object:update(dt)
    end
end

function createHeader(path)
    local header = {}
    header.sprite = love.graphics.newImage(path)
    header.x = WINDOW_WIDTH/2 - header.sprite:getWidth()/2
    header.y = 10

    return header
end

function removeObjectFromMap(t, object)
    local index = table.indexOf(t, object)
    table.remove(t, index)
    object.collider:destroy()
end

function table.indexOf(t, object)
    if type(t) ~= "table" then error("table expected, got " .. type(t), 2) end

    for i, v in pairs(t) do
        if object == v then
            return i
        end
    end
end

--[[
function isClikingOnButton(button)
    local mouseX, mouseY = love.mouse.getPosition()
    local bool = mouseX > button.x and mouseX < button.x + button.width and
            mouseY > button.y and mouseY < button.y + button.height

    return bool
end]]
