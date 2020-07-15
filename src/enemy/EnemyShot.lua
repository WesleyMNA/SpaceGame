require('src.Util')
require('src.Animation')

EnemyShot = {}
EnemyShot.__index = EnemyShot

function EnemyShot:new(x, y, world, enemy)
    local this = {
        class = 'EnemyShot',

        spritesheet = love.graphics.newImage('sprites/enemy/shot.png'),
        x = x,
        y = y,
        width = 16,
        height = 16,
        speed = 500,

        enemy = enemy,
        state = 'move'
    }


    this.collider = world:newCircleCollider(x+this.width/2, y+this.height/2, 3)
    this.collider:setCollisionClass('EnemyShot')

    this.behaviors = {
        move = function(dt)
            if this.x < -10 or this.collider:enter('Player') then
                this.state = 'collide'
            else
                this.x = this.x - this.speed * dt
            end
        end,
        collide = function(dt)
            removeObjectFromMap(this.enemy.shots, this)
        end
    }

    setmetatable(this, self)
    return this
end

function EnemyShot:update(dt)
    self.behaviors[self.state](dt)
    if self.collider.body then
        self.collider:setPosition(self.x+self.width/2, self.y+self.height/2)
    end
end

function EnemyShot:render()
    love.graphics.setColor(255,255,255,1)
    love.graphics.draw(self.spritesheet, self.x, self.y)
end
