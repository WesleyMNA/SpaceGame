require('src.enemy.EnemyShot')

SmallEnemy = {}
SmallEnemy.__index = SmallEnemy

function SmallEnemy:new(x, y, enimiesTable, world, movementNumber)
    local this = {
        class = 'SmallEnemy',

        spritesheet = love.graphics.newImage('sprites/enemy/enemy-small.png'),
        explosion = Explosion:new(),
        x = x,
        y = y,
        width = 16,
        height = 16,
        startY = y,

        isAlive = true,

        shotSpeed = 1,
        shotTimer = 1,
        shots = {},

        enimiesTable = enimiesTable
    }


    this.collider = world:newRectangleCollider(x, y, this.width, this.height)
    this.collider:setCollisionClass('Enemy')

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
--        curve = function(dt)
--            local speed = 1
--            this.x = this.x - speed * dt
--            this.y = this.y^2 * dt
--            print(this.y)
--        end,
    }

    this.attack = function(dt)
        if not this.isAlive then return end

        this.shotTimer = this.shotTimer + dt
        if this.shotTimer > this.shotSpeed then
            local shot = EnemyShot:new(
                this.x - this.width,
                this.y - this.height/2,
                world,
                this
            )
            table.insert(this.shots, shot)
            this.shotTimer = 0
        end
    end

    setmetatable(this, self)
    setmetatable(self, BaseEnemy)
    this:setCurrentMovement(movementNumber)
    return this
end
