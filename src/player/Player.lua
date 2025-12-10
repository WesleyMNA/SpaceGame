require('src.Util')
require('src.player.machine_gun')
require('src.player.ships_data')

local window = require('src.utils.window')

local explosionSound = love.audio.newSource('sounds/player/explosion.wav', 'static')

Player = {}
Player.__index = Player

function Player:new(x, y, world, shipNumber)
    local this = {
        class = 'Player',

        spritesheet = SHIPS_DATA[shipNumber].sprite,
        x = x,
        y = y,

        current_ship = SHIPS_DATA[shipNumber],
        hit = love.audio.newSource('sounds/player/hit.wav', 'static'),

        world = world,
    }

    this.machine_gun = MachineGun:new(world, this, this.current_ship.shot)
    this.health = this.current_ship.health
    this.speed = this.current_ship.speed

    this.width = this.spritesheet:getWidth()
    this.height = this.spritesheet:getHeight()

    this.collider = world:newCircleCollider(x + this.width / 2, y + this.height / 2, this.current_ship.radius)
    this.collider:setCollisionClass('Player')

    this.explosion = Explosion:new(this)

    this.move = function(dt)
        if love.mouse.isDown(1) then
            local mouseX, mouseY = love.mouse.getPosition()
            if this.y > mouseY then
                this.y = this.y - this.speed * dt
            end
            if this.y < mouseY and not this:is_on_the_bottom_edge() then
                this.y = this.y + this.speed * dt
            end
            if this.x > mouseX then
                this.x = this.x - this.speed * dt
            end
            if this.x < mouseX and not this:is_on_the_right_edge() then
                this.x = this.x + this.speed * dt
            end
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
    if self:is_alive() then
        self.move(dt)
        self.machine_gun:update(dt)
        self.collide(dt)
        self.collider:setPosition(self.x + self.width / 2, self.y + self.height / 2)
    else
        self.explosion:update(dt)
        love.audio.play(explosionSound)
    end
end

function Player:draw()
    if self:is_alive() then
        love.graphics.setColor(255, 255, 255, 1)
        love.graphics.draw(self.spritesheet, self.x, self.y)

        love.graphics.setColor(0, 255, 0, 1)
        love.graphics.print('Health: ' .. self.health)

        self.machine_gun:draw()
    else
        self.explosion:draw()
    end
end

local delimiter = 50

function Player:is_on_the_right_edge()
    return self.x + self.width >= window.get_width() - delimiter
end

function Player:is_on_the_bottom_edge()
    return self.y + self.height >= window.get_height()
end

function Player:is_alive()
    if self.health <= 0 then return false end
    return true
end

function Player:getPosition()
    return self.x, self.y
end

function Player:is_dead()
    return not self:is_alive() and self.explosion.animation:hasFinished()
end
