require('src.Util')
require('src.Animation')

Shot = {}
Shot.__index = Shot

function Shot:new(x, y, ship, world, shotsTable)
    local this = {
        class = 'Shot',

        spritesheet = love.graphics.newImage('sprites/player/ship'..ship.number..'/shot.png'),
        x = x,
        y = y,

        currentShot = ship.shot,
        shotsTable = shotsTable,
        state = 'move'
    }

    this.width = this.currentShot.width
    this.height = this.currentShot.height
    this.speed = this.currentShot.speed

    this.quad = love.graphics.newQuad(0, 0, this.width, this.height, this.spritesheet:getDimensions())

    this.collider = world:newCircleCollider(x+this.width/2, y+this.height/2, this.currentShot.radius)
    this.collider:setCollisionClass('Shot')

    this.animation = {
        move = Animation:new(this.quad, this.currentShot.move),
        collide = Animation:new(this.quad, this.currentShot.collide)
    }

    this.behaviors = {
        move = function(dt)
            if this.x > WINDOW_WIDTH - 50 or this.collider:enter('Enemy') then
                this.state = 'collide'
            else
                this.x = this.x + this.speed * dt
            end
        end,
        collide = function(dt)
            this.collider:setCollisionClass('Ignore') -- ignore collision while animation is playing
            if this.animation[this.state]:hasFinished() then
                removeObjectFromMap(this.shotsTable, this)
            end
        end
    }
    
    setmetatable(this, self)
    return this
end

function Shot:update(dt)
    self.behaviors[self.state](dt)
    self.animation[self.state]:update(dt)
    if self.collider.body then
        self.collider:setPosition(self.x+self.width/2, self.y+self.height/2)
    end
end

function Shot:render()
    love.graphics.setColor(255,255,255,1)
    love.graphics.draw(self.spritesheet, self.quad, self.x, self.y)
end
