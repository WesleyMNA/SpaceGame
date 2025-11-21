require('src.Util')
require('src.player.Player')
require('src.enemy.EnemyGenerator')
require('src.CreateCollisionClasses')

RECORD = 0

function createTimer()
    TIMER = 0
end

local enemiesTimer = 0
local wf = require 'libs.windfield'

Map = {}
Map.__index = Map

function Map:new(ship)
    local this = {
        class = 'Map',

        mapWidth = math.floor(WINDOW_WIDTH / 64),
        mapHeight = math.floor(WINDOW_HEIGHT / 64),
        world = wf.newWorld(0, 0, true),
        enemies = {}
    }

    createTimer()

    createCollisionClasses(this.world)
    this.player = Player:new(WINDOW_HEIGHT / 2, 100, this.world, ship)
    this.enemyGenerator = EnemyGenerator:new(this)

    local pauseIcon = 'sprites/gui/buttons/pause.png'
    local buttonX = WINDOW_WIDTH - 50
    local buttonY = 0
    this.pauseButton = Button:new(buttonX, buttonY, pauseIcon)

    setmetatable(this, self)
    return this
end

function Map:update(dt)
    TIMER = TIMER + dt
    self.world:update(dt)
    self.player:update(dt)
    self.enemyGenerator:update(dt)
    updateLoop(dt, self.enemies)
end

function Map:mousepressed(x, y)
    if self.pauseButton:is_clicked(x, y) then CURRENT_GUI = 'pause' end
end

function Map:render()
    self.pauseButton:render()
    self.player:render()
    renderLoop(self.enemies)
    --    self.world:draw()

    love.graphics.setColor(255, 255, 0, 1)
    love.graphics.print('Time: ' .. math.floor(TIMER) .. ' seconds', 75, 0)
end

function Map:addEnemy(enemy)
    table.insert(self.enemies, enemy)
end

function Map:removeEnemy(enemy)
    local index = table.indexOf(self.enemies, enemy)
    table.remove(self.enemies, index)
    enemy.collider:destroy()
end
