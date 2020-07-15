require('src.Animation')

Explosion = {}
Explosion.__index = Explosion

function Explosion:new()
    local this = {
        class = 'Explosion',
        spritesheet = love.graphics.newImage('sprites/enemy/explosion.png')
    }

    this.quad = love.graphics.newQuad(0, 0, 16, 16, this.spritesheet:getDimensions())
    this.animation = Animation:new(this.quad, 10, 5, 0)

    setmetatable(this, self)
    return this
end

function Explosion:update(dt, x, y)
    self.x = x
    self.y= y
    self.animation:update(dt)
end

function Explosion:render()
    love.graphics.setColor(255, 255, 255, 1)
    love.graphics.draw(self.spritesheet, self.quad, self.x, self.y)
end
