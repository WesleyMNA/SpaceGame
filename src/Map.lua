require('src.Util')
require('src.player.Player')
require('src.enemy.EnemyGenerator')
require('src.CreateCollisionClasses')

POINTS = 0
local enemiesTimer = 0
local wf = require 'libs.windfield'

Map = {}
Map.__index = Map

function Map:new(randomNumber, ship)
    local this = {
        tile = love.graphics.newImage('sprites/map/Space_Stars'..randomNumber..'.png'),
        mapWidth = math.floor(WINDOW_WIDTH / 64),
        mapHeight = math.floor(WINDOW_HEIGHT / 64),
        world = wf.newWorld(0, 0, true),
        enemies = {}
    }

    this.spriteBatch = love.graphics.newSpriteBatch(this.tile, this.mapWidth * this.mapHeight)

    createCollisionClasses(this.world)
    this.player = Player:new(WINDOW_HEIGHT/2, 100, this.world, ship)
    this.enemyGenerator = EnemyGenerator:new(this)

    for y = 0, this.mapHeight do
        for x = 0, this.mapWidth do
            this.spriteBatch:add(x * 64, y * 64)
        end
    end

    setmetatable(this, self)
    return this
end

function Map:update(dt)
    self.world:update(dt)
    self.player:update(dt)
    self.enemyGenerator:update(dt)
    updateLoop(dt, self.enemies)
end

function Map:render()
    love.graphics.setColor(255, 255, 255, 0.3)
    love.graphics.draw(self.spriteBatch)
    self.player:render()
    renderLoop(self.enemies)
--    self.world:draw()

    love.graphics.setColor(255, 255, 0, 1)
    love.graphics.print('Points: ' .. POINTS, 0, 15)
end

function Map:addEnemy(enemy)
    table.insert(self.enemies, enemy)
end

function Map:removeEnemy(enemy)
    local index = table.indexOf(self.enemies, enemy)
    table.remove(self.enemies, index)
    enemy.collider:destroy()
end
