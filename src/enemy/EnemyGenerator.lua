require('src.enemy.Bomb')
require('src.enemy.SmallEnemy')

EnemyGenerator = {}
EnemyGenerator.__index = EnemyGenerator

WINDOW_END = -10

function EnemyGenerator:new(map)
    local this = {
        class = 'EnemyGenerator',

        map = map,
        enemyTimer = 0
    }

    setmetatable(this, self)
    return this
end

function EnemyGenerator:update(dt)
    self.enemyTimer = self.enemyTimer - 2 * dt
    if self.enemyTimer <= 0 then

        if math.random(2) == 1 then
            self:createBombs()
        end

        if math.random(5) == 1 then
            self:createSmallEnemy()
        end

        self.enemyTimer = 5
    end
end

function EnemyGenerator:createBombs()
    local bomb
    local movementNumber = math.random(2)
    local spriteNumber = math.random(0, 1)
    local y = math.random(50, WINDOW_HEIGHT - 50)

    for i=1,5 do
        local delimiter = 25 * i
        bomb = Bomb:new(
            800 + delimiter, y,
            self.map.enemies, self.map.world,
            spriteNumber, movementNumber
        )
        self.map:addEnemy(bomb)
    end
end

function EnemyGenerator:createSmallEnemy()
    local smallEnemy
    local movementNumber = math.random(2)
    local y = math.random(50, WINDOW_HEIGHT - 50)
    smallEnemy = SmallEnemy:new(800, y, self.map.enemies, self.map.world, movementNumber)
    self.map:addEnemy(smallEnemy)
end
