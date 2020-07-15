require('src.player.Player')
require('src.enemy.EnemyGenerator')
require('src.Util')

Map = {}
Map.__index = Map

local enemiesTimer = 0

function Map:new(world)
    local this = {
        world = world,
        enemies = {}
    }

    this.player = Player:new(100, 280, world)
    this.enemyGenerator = EnemyGenerator:new(this)

    setmetatable(this, self)
    return this
end

function Map:update(dt)
    self.player:update(dt)
    self.enemyGenerator:update(dt)
    updateLoop(dt, self.enemies)
end

function Map:render()
    self.player:render()
    renderLoop(self.enemies)

    love.graphics.setColor(0, 0, 255, 1)
    love.graphics.print('Points: ' .. POINTS, 0, 15)
end

function Map:addEnemy(enemy)
    table.insert(self.enemies, enemy)
end