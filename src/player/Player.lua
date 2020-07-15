require('src.player.Shot')
require('src.Util')

Player = {}
Player.__index = Player

function Player:new(x, y, world)
    local this = {
        class = 'Player',

        spritesheet = love.graphics.newImage('sprites/player/Ship1/Ship1.png'),
        x = x,
        y = y,
        width = 64,
        height = 64,

        health = 10,
        speed = 300,

        shotSpeed = 0.25,
        shotTimer = 0.25,
        shots = {}
    }

    this.collider = world:newCircleCollider(x+this.width/2, y+this.height/2, 17)
    this.collider:setCollisionClass('Player')

    this.move = function(dt)
        if love.mouse.isDown(1) then
            local mouseX, mouseY = love.mouse.getPosition()
            if this.y > mouseY then
                this.y = this.y - this.speed * dt
            end
            if this.y < mouseY and not this:isOnBottomEdge() then
                this.y = this.y + this.speed * dt
            end
            if  this.x > mouseX then
                this.x = this.x - this.speed * dt
            end
            if  this.x < mouseX and not this:isOnRightEdge() then
                this.x = this.x + this.speed * dt
            end
        end
    end

    this.attack = function(dt)
        this.shotTimer = this.shotTimer + dt
        if this.shotTimer > this.shotSpeed then
            local shot = Shot:new(
                this.x + this.width,
                this.y + 16,
                world,
                this.shots
            )
            table.insert(this.shots, shot)
            this.shotTimer = 0
        end
    end

    this.collide = function(dt)
        if this.collider:enter('Enemy') or this.collider:enter('EnemyShot') then
            this.health = this.health - 1
        end
    end

    setmetatable(this, self)
    return this
end

function Player:update(dt)
    self.move(dt)
    self.attack(dt)
    self.collide(dt)
    self.collider:setPosition(self.x+self.width/2, self.y+self.height/2)

    updateLoop(dt, self.shots)

    self:isDead()
end

function Player:render()
    love.graphics.setColor(255,255,255,1)
    love.graphics.draw(self.spritesheet, self.x, self.y)

    love.graphics.setColor(0,255,0,1)
    love.graphics.print(self.health)

    renderLoop(self.shots)
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

function Player:isDead()
    if self.health <= 0 then
        RUN = false
    end
end

function Player:getMiddle()
    local x = self.x + self.width/2
    local y =  self.y + self.height/2

    return x, y
end