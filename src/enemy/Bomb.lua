require('src.enemy.Explosion')
require('src.enemy.BaseEnemy')

Bomb = {}
Bomb.__index = Bomb

local amplitude = 10
local lambda = 25

function Bomb:new(x, y, enimiesTable, world, spriteNumber, movementNumber)
    local this = {
        class = 'Bomb',

        spritesheet = love.graphics.newImage('sprites/enemy/bomb.png'),
        explosion = Explosion:new(),
        x = x,
        y = y,
        width = 16,
        height = 16,
        startY = y,

        isAlive = true,
        shots = false,
        enimiesTable = enimiesTable
    }

    this.quad = love.graphics.newQuad(
        16 * spriteNumber, 0,
        this.width, this.height,
        this.spritesheet:getDimensions()
    )

    this.collider = world:newRectangleCollider(x, y, this.width, this.height)
    this.collider:setCollisionClass('Enemy')

    this.movements = {
        straight = function(dt)
            local speed = 200
            this.x = this.x - speed * dt
        end,
        wave = function(dt)
            local speed = 200
            this.x = this.x - speed / 2 * dt
            this.y = this.y - amplitude * math.cos(math.pi/lambda * this.x)
        end,
    }

    setmetatable(this, self)
    setmetatable(self, BaseEnemy)
    this:setCurrentMovement(movementNumber)
    return this
end

