require('src.Animation')

EnemyExplosion = {}
EnemyExplosion.__index = EnemyExplosion

function EnemyExplosion:new(enemy)
    local this = {
        class = 'EnemyExplosion',
        spritesheet = love.graphics.newImage('sprites/enemy/explosion.png'),
        enemy = enemy
    }

    this.quad = love.graphics.newQuad(0, 0, 16, 16, this.spritesheet:getDimensions())
    this.animation = Animation:new(this.quad, 10, 5, 0)

    setmetatable(this, self)
    return this
end

function EnemyExplosion:update(dt)
    self.x, self.y = self.enemy:getPosition()
    self.animation:update(dt)
end

function EnemyExplosion:render()
    love.graphics.setColor(255, 255, 255, 1)
    love.graphics.draw(self.spritesheet, self.quad, self.x, self.y)
end
