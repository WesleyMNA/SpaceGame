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

function removeObjectFromMap(t, objetc)
    local index = table.indexOf(t, objetc)
    table.remove(t, index)
    objetc.collider:destroy()
end

function table.indexOf(t, object)
    if type(t) ~= "table" then error("table expected, got " .. type(t), 2) end

    for i, v in pairs(t) do
        if object == v then
            return i
        end
    end
end

function isClikingOnButton(button)
    local mouseX, mouseY = love.mouse.getPosition()
    local bool = mouseX > button.x and mouseX < button.x + button.width and
            mouseY > button.y and mouseY < button.y + button.height

    return bool
end