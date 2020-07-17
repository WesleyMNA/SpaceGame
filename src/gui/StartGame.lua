require('src.Util')

StartGame = {}
StartGame.__index = StartGame

function StartGame:new()
    local this = {
        class = 'StartGame',

        startButton = love.graphics.newImage('sprites/gui/start-button.png'),
        x = (WINDOW_WIDTH / 2) - 26,
        y = (WINDOW_HEIGHT / 2) - 8
    }

    this.width = this.startButton:getWidth()
    this.height = this.startButton:getHeight()

    setmetatable(this, self)
    return this
end

function StartGame:update(dt)
    if love.mouse.isDown(1) then --and isClikingOnButton(self) then
        RUN = true
    end
end

function StartGame:render()
    love.graphics.setColor(255, 255, 255, 1)
    love.graphics.draw(self.startButton, self.x, self.y)
end
