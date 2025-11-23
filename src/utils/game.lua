local game = {}

function game.draw(objects)
    for _, object in pairs(objects) do
        object:draw()
    end
end

function game.update(objects, dt)
    for _, object in pairs(objects) do
        object:update(dt)
    end
end

function game.mousepressed(objects, x, y)
    for _, object in pairs(objects) do
        object:mousepressed(x, y)
    end
end

return game
