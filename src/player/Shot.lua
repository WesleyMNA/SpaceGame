require('src.Util')
require('src.Animation')

Shot = {}
Shot.__index = Shot

function Shot:new(x, y, ship, world, shotsTable)
    local shot_data = ship.shot

    local this = {
        class = 'Shot',

        spritesheet = love.graphics.newImage('sprites/player/ship' .. ship.id .. '/shot.png'),
        x = x,
        y = y,
        width = shot_data.width,
        height = shot_data.height,
        speed = shot_data.speed,

        shotsTable = shotsTable,
        state = 'move'
    }

    this.quad = love.graphics.newQuad(0, 0, this.width, this.height, this.spritesheet:getDimensions())
    this.collider = world:newCircleCollider(x, y, shot_data.radius)
    this.collider:setCollisionClass('Shot')

    this.animation = {
        move = Animation:new(this.quad, shot_data.move),
        collide = Animation:new(this.quad, shot_data.collide)
    }

    this.behaviors = {
        move = function(dt)
            if this:isOutOfMap() or this.collider:enter('Enemy') then
                this.state = 'collide'
            else
                this.x = this.x + this.speed * dt
            end
        end,
        collide = function(dt)
            local colliderClass = SHIPS_DATA[ship.id].shot.collide.class
            this.collider:setCollisionClass(colliderClass)
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
        self.collider:setPosition(self.x, self.y)
    end
end

function Shot:draw()
    love.graphics.setColor(255, 255, 255, 1)
    love.graphics.draw(
        self.spritesheet,
        self.quad,
        self.collider:getX(),
        self.collider:getY(),
        0,
        1,
        1,
        self.width / 2,
        self.height / 2
    )
end

function Shot:isOutOfMap()
    return self.collider:getX() > WINDOW_WIDTH - 50
end
