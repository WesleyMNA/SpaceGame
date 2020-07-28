require('src.enemy.EnemyShot')

MediumEnemy = {}
MediumEnemy.__index = MediumEnemy

function MediumEnemy:new(x, y, map, movementNumber)
    local this = {
        class = 'MediumEnemy',

        spritesheet = love.graphics.newImage('sprites/enemy/enemy-medium.png'),
        x = x,
        y = y,
        width = 16,
        height = 32,
        startY = y,

        isAlive = true,

        health= 2,
        shotSpeed = 1,
        shotTimer = 1,
        shots = {},

        map = map
    }

    this.collider = map.world:newRectangleCollider(x, y, this.width, this.height)
    this.collider:setCollisionClass('Enemy')
    this.explosion = EnemyExplosion:new(this)

    this.movements = {
        straight = function(dt)
            local speed = 200
            this.x = this.x - speed * dt
        end,
        xLine = function(dt)
            local speed = 50
            this.x = this.x - 5 * speed * dt
            if this.startY >= WINDOW_HEIGHT/2 then
                this.y = this.y - speed * dt
            else
                this.y = this.y + speed * dt
            end
        end,
        wave = function(dt)
            local amplitude = WINDOW_HEIGHT / 3
            local lambda = WINDOW_HEIGHT / 4
            local speed = 100
            this.x = this.x - speed / 2 * dt
            this.y = (WINDOW_HEIGHT/2) - amplitude * math.cos(math.pi/lambda * this.x)
        end
    }

    this.attack = function(dt)
        if not this.isAlive then return end

        this.shotTimer = this.shotTimer + dt
        if this.shotTimer > this.shotSpeed then
            this:shoot()
            this.shotTimer = 0
        end
    end

    setmetatable(this, self)
    this:setMovement(movementNumber)
    return this
end

function MediumEnemy:update(dt)
    self:die()
    if self.isAlive then
        self.movements[self.currentMovement](dt)
    else
        self.explosion:update(dt)
    end

    self.attack(dt)
    updateLoop(dt, self.shots)
    self:collide(dt)

    if self.collider.body then
        self.collider:setPosition(self.x+self.width/2, self.y+self.height/2)
    end
end

function MediumEnemy:render()
    love.graphics.setColor(255, 255, 255, 1)
    if self.isAlive then
        love.graphics.draw(self.spritesheet, self.x, self.y)
    else
        self.explosion:render()
    end
    renderLoop(self.shots)
end

function MediumEnemy:collide(dt)
    if self.x <= WINDOW_LIMIT then
        self.map:removeEnemy(self)
    elseif self.collider:enter('Player') then
        self.health = self.health - 100
    elseif self.collider:enter('Shot') then
        self.health = self.health - 1
    end

    if self.explosion.animation:hasFinished() and #self.shots == 0 then
        self.map:removeEnemy(self)
    end
end

function MediumEnemy:shoot()
    local shot = EnemyShot:new(
        self.x, self.y+6,
        self.map.world, self
    )
    table.insert(self.shots, shot)
end

function MediumEnemy:die()
    if self.health <= 0 and self.isAlive then
        self.isAlive = false
        POINTS = POINTS + 10
        self.collider:setCollisionClass('Ignore')
    end
end

function MediumEnemy:getPosition()
    return self.x, self.y
end

function MediumEnemy:setMovement(randomNumber)
    local movementKeys = {}
    for i in pairs(self.movements) do
        table.insert(movementKeys, i)
    end
    self.currentMovement = movementKeys[randomNumber]
end
