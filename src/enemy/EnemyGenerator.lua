require('src.enemy.Bomb')
require('src.enemy.SmallEnemy')
require('src.enemy.MediumEnemy')

EnemyGenerator = {}
EnemyGenerator.__index = EnemyGenerator

WINDOW_LIMIT = -10

function EnemyGenerator:new(map)
    local this = {
        class = 'EnemyGenerator',

        map = map,
        gameTime = 0,
        enemyTimer = 0,
        bombPercentage = 1,
        smallPercentage = 10,
        mediumPercenage = 20,
    }

    setmetatable(this, self)
    return this
end

function EnemyGenerator:update(dt)
    self:increaseDifficulty(dt)

    self.enemyTimer = self.enemyTimer - 2 * dt
    if self.enemyTimer <= 0 then

        if math.random(self.bombPercentage) == 1 then
            self:createBombs()
        end

        if math.random(self.smallPercentage) == 1 then
            self:createSmallEnemy()
        end

        if math.random(self.mediumPercenage) == 1 then
            self:createMediumEnemy()
        end

        self.enemyTimer = 5
    end
end

function EnemyGenerator:createBombs()
    local bomb
    local movementNumber = math.random(3)
    local spriteNumber = math.random(0, 1)
    local y = math.random(50, WINDOW_HEIGHT - 50)

    for i=1,5 do
        local delimiter = 25 * i
        bomb = Bomb:new(
            WINDOW_WIDTH + delimiter, y, self.map,
            spriteNumber, movementNumber
        )
        self.map:addEnemy(bomb)
    end
end

function EnemyGenerator:createSmallEnemy()
    local smallEnemy
    local movementNumber = math.random(3)
    local y = math.random(50, WINDOW_HEIGHT - 50)
    smallEnemy = SmallEnemy:new(WINDOW_WIDTH, y, self.map, movementNumber)
    self.map:addEnemy(smallEnemy)
end

function EnemyGenerator:createMediumEnemy()
    local mediumEnemy
    local movementNumber = math.random(3)
    local y = math.random(50, WINDOW_HEIGHT - 50)
    mediumEnemy = MediumEnemy:new(WINDOW_WIDTH, y, self.map, movementNumber)
    self.map:addEnemy(mediumEnemy)
end

local function changePercentage(number)
    if number <= 1 then
        number = 1
    else
        number = number - 1
    end
    return number
end

function EnemyGenerator:increaseDifficulty(dt)
    self.gameTime = self.gameTime + 1
    if self.gameTime > 0 and self.gameTime % 500 == 0 then
        self.bombPercentage = changePercentage(self.bombPercentage)
        self.smallPercentage = changePercentage(self.smallPercentage)
        self.mediumPercenage = changePercentage(self.mediumPercenage)
    end
end
