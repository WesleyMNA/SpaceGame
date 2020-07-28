require('src.enemy.Explosion')

Bomb = {}
Bomb.__index = Bomb

function Bomb:new(x, y, map, spriteNumber, movementNumber)
    local this = {
        class = 'Bomb',

        spritesheet = love.graphics.newImage('sprites/enemy/bomb.png'),
        x = x,
        y = y,
        width = 16,
        height = 16,
        startY = y,

        isAlive = true,
        shots = false,
        map = map
    }

    this.quad = love.graphics.newQuad(
        16 * spriteNumber, 0,
        this.width, this.height,
        this.spritesheet:getDimensions()
    )

    this.collider = map.world:newRectangleCollider(x, y, this.width, this.height)
    this.collider:setCollisionClass('Enemy')
    this.explosion = EnemyExplosion:new(this)

    this.movements = {
        straight = function(dt)
            local speed = 200
            this.x = this.x - speed * dt
        end,
        smallWave = function(dt)
            local amplitude = WINDOW_HEIGHT / 40
            local lambda = WINDOW_HEIGHT / 16
            local speed = 200
            this.x = this.x - speed / 2 * dt
            this.y = this.y - amplitude * math.cos(math.pi/lambda * this.x)
        end,
        bigWave = function(dt)
            local amplitude = WINDOW_HEIGHT / 3
            local lambda = WINDOW_HEIGHT / 4
            local speed = 200
            this.x = this.x - speed / 2 * dt
            this.y = (WINDOW_HEIGHT/2) - amplitude * math.cos(math.pi/lambda * this.x)
        end
    }

    setmetatable(this, self)
    this:setMovement(movementNumber)
    return this
end

function Bomb:update(dt)
    if self.isAlive then
        self.movements[self.currentMovement](dt)
    else
        self.explosion:update(dt)
    end

    self:collide(dt)

    if self.collider.body then
        self.collider:setPosition(self.x+self.width/2, self.y+self.height/2)
    end
end

function Bomb:render()
    love.graphics.setColor(255, 255, 255, 1)
    if self.isAlive then
        love.graphics.draw(self.spritesheet, self.quad, self.x, self.y)
    else
        self.explosion:render()
    end
end

function Bomb:collide(dt)
    if self.x <= WINDOW_LIMIT then
        self.map:removeEnemy(self)
    elseif self.collider:enter('Player') then
        self.isAlive = false
        self.collider:setCollisionClass('Ignore')
    elseif self.collider:enter('Shot') then
        self.isAlive = false
        POINTS = POINTS + 10
        self.collider:setCollisionClass('Ignore')
    end

    if self.explosion.animation:hasFinished() then
        self.map:removeEnemy(self)
    end
end

function Bomb:setMovement(randomNumber)
    local movementKeys = {}
    for i in pairs(self.movements) do
        table.insert(movementKeys, i)
    end
    self.currentMovement = movementKeys[randomNumber]
end

function Bomb:getPosition()
    return self.x, self.y
end