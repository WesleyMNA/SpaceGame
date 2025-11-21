require('src.Animation')

Explosion = {}
Explosion.__index = Explosion

local explosionData = {
    enemy = {},
    player = {}
}
explosionData.enemy.spritesheet = love.graphics.newImage('sprites/enemy/explosion.png')
explosionData.enemy.quad = love.graphics.newQuad(
    0, 0, 16, 16,
    explosionData.enemy.spritesheet:getDimensions()
)
explosionData.enemy.t = {
    fps = 10,
    frames = 5,
    xoffsetMul = 32,
    yoffset = 0
}

explosionData.player.spritesheet = love.graphics.newImage('sprites/player/explosion.png')
explosionData.player.quad = love.graphics.newQuad(
    0, 0, 128, 128,
    explosionData.player.spritesheet:getDimensions()
)
explosionData.player.t = {
    fps = 10,
    frames = 11,
    xoffsetMul = 128,
    yoffset = 0
}

function Explosion:new(object)
    local this = {
        class = 'Explosion',
        object = object
    }

    if object.class == 'Player' then
        this.animation = Animation:new(explosionData.player.quad , explosionData.player.t)
    else
        this.animation = Animation:new(explosionData.enemy.quad , explosionData.enemy.t)
    end

    setmetatable(this, self)
    return this
end

function Explosion:update(dt)
    self.x, self.y = self.object:getPosition()
    self.animation:update(dt)
end

function Explosion:draw()
    love.graphics.setColor(255, 255, 255, 1)
    if self.object.class == 'Player' then
        love.graphics.draw(
            explosionData.player.spritesheet,
            explosionData.player.quad,
            self.x, self.y
        )
    else
        love.graphics.draw(
            explosionData.enemy.spritesheet,
            explosionData.enemy.quad,
            self.x, self.y
        )
    end
end
