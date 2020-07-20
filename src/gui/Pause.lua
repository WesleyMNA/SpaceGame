Pause = {}
Pause.__index = Pause

function Pause:new()
    local this = {
        class = 'Pause',

    }

    setmetatable(this, self)
    return this
end

function Pause:update(dt)

end

function Pause:render()

end
