require('src.Util')
require('src.player.Shot')
require('src.player.ShipsData')

local explosionSound = love.audio.newSource('sounds/player/explosion.wav', 'static')

Player = {}
Player.__index = Player

function Player:new(x, y, world, shipNumber)
    local this = {
        class = 'Player',

        spritesheet = SHIPS_DATA[shipNumber].sprite,
        x = x,
        y = y,

        currentShip = SHIPS_DATA[shipNumber],
        hit = love.audio.newSource('sounds/player/hit.wav', 'static'),

        world = world,
        shots = {}
    }

    this.health = this.currentShip.health
    this.speed = this.currentShip.speed

    this.shotSpeed = this.currentShip.shotSpeed
    this.shotTimer = this.shotSpeed

    this.shotX = this.currentShip.shotX
    this.shotY = this.currentShip.shotY

    this.width = this.spritesheet:getWidth()
    this.height = this.spritesheet:getHeight()

    this.collider = world:newCircleCollider(x + this.width / 2, y + this.height / 2, this.currentShip.radius)
    this.collider:setCollisionClass('Player')

    this.explosion = Explosion:new(this)

    this.move = function(dt)
        if love.mouse.isDown(1) then
            local mouseX, mouseY = love.mouse.getPosition()
            if this.y > mouseY then
                this.y = this.y - this.speed * dt
            end
            if this.y < mouseY and not this:isOnBottomEdge() then
                this.y = this.y + this.speed * dt
            end
            if this.x > mouseX then
                this.x = this.x - this.speed * dt
            end
            if this.x < mouseX and not this:isOnRightEdge() then
                this.x = this.x + this.speed * dt
            end
        end
    end

    this.attack = function(dt)
        this.shotTimer = this.shotTimer + dt
        if this.shotTimer > this.shotSpeed then
            this:shoot()
            this.shotTimer = 0
        end
    end

    this.collide = function(dt)
        if this.collider:enter('Enemy') or this.collider:enter('EnemyShot') then
            this.health = this.health - 1
            love.audio.play(this.hit)
        end
    end

    setmetatable(this, self)
    return this
end

function Player:update(dt)
    if self:isAlive() then
        self.move(dt)
        self.attack(dt)
        self.collide(dt)
        self.collider:setPosition(self.x + self.width / 2, self.y + self.height / 2)

        updateLoop(dt, self.shots)
    else
        self.explosion:update(dt)
        love.audio.play(explosionSound)
    end
end

function Player:draw()
    if self:isAlive() then
        love.graphics.setColor(255, 255, 255, 1)
        love.graphics.draw(self.spritesheet, self.x, self.y)

        love.graphics.setColor(0, 255, 0, 1)
        love.graphics.print('Health: ' .. self.health)

        renderLoop(self.shots)
    else
        self.explosion:draw()
    end
end

function Player:shoot()
    local shot = Shot:new(
        self.x + self.shotX,
        self.y + self.shotY,
        self.currentShip, self.world, self.shots
    )
    love.audio.play(self.currentShip.shot.sound)
    table.insert(self.shots, shot)
end

function Player:isOnRightEdge()
    local delimiter = 50
    if self.x + self.width >= WINDOW_WIDTH - delimiter then
        return true
    end
    return false
end

function Player:isOnBottomEdge()
    if self.y + self.height >= WINDOW_HEIGHT then
        return true
    end
    return false
end

function Player:isAlive()
    if self.health <= 0 then return false end
    return true
end

function Player:getPosition()
    return self.x, self.y
end

function Player:is_dead()
    return not self:isAlive() and self.explosion.animation:hasFinished()
end
