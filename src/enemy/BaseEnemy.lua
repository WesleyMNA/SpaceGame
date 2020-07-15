BaseEnemy = {}
BaseEnemy.__index = BaseEnemy

function BaseEnemy:update(dt)
    if self.isAlive then
        self.movements[self.currentMovement](dt)
    else
        self.explosion.animation:update(dt)
    end

    if self.shots then
        self.attack(dt)
        updateLoop(dt, self.shots)
    end

    self:collide(dt)

    if self.collider.body then
        self.collider:setPosition(self.x+self.width/2, self.y+self.height/2)
    end
end

function BaseEnemy:render()
    love.graphics.setColor(255, 255, 255, 1)
    if self.isAlive then
        if self.quad then
            love.graphics.draw(self.spritesheet, self.quad, self.x, self.y)
        else
            love.graphics.draw(self.spritesheet, self.x, self.y)
        end

        if self.shots then
            renderLoop(self.shots)
        end
    else
        love.graphics.draw(self.explosion.spritesheet, self.explosion.quad, self.x, self.y)
    end
end

function BaseEnemy:collide(dt)
    if self.x <= WINDOW_END then
        removeObjectFromMap(self.enimiesTable, self)
    elseif self.collider:enter('Shot') or self.collider:enter('Player') then
        self.isAlive = false
        self.collider:setCollisionClass('Ignore')
    end

    if self.explosion.animation:hasFinished() and
            (self.shots == false or #self.shots == 0) then
        removeObjectFromMap(self.enimiesTable, self)
        POINTS = POINTS + 10
    end
end

function BaseEnemy:setCurrentMovement(randomNumber)
    local movementKeys = {}
    for i in pairs(self.movements) do
        table.insert(movementKeys, i)
    end
    self.currentMovement = movementKeys[randomNumber]
end