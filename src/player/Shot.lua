require('src.Util')
require('src.Animation')

Shot = {}
Shot.__index = Shot

function Shot:new(x, y, world, shotsTable)
    local this = {
        class = 'Shot',

        spritesheet = love.graphics.newImage('sprites/player/Shots/Shot1/shot1.png'),
        x = x,
        y = y,
        width = 32,
        height = 32,
        speed = 300,

        shotsTable = shotsTable,
        state = 'move'
    }

    this.quad = love.graphics.newQuad(0, 0, 32, 32, this.spritesheet:getDimensions())

    this.collider = world:newCircleCollider(x+this.width/2, y+this.height/2, 3)
    this.collider:setCollisionClass('Shot')

    this.animation = {
        move = Animation:new(this.quad, 10, 4, 0),
        collide = Animation:new(this.quad, 10, 5, 32)
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
