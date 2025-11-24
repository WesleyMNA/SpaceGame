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

function Map:new(ship, manager)
    local this = {
        class = 'Map',
        manager = manager,
        mapWidth = math.floor(WINDOW_WIDTH / 64),
        mapHeight = math.floor(WINDOW_HEIGHT / 64),
        world = wf.newWorld(0, 0, true),
        enemies = {}
    }

    createTimer()

    createCollisionClasses(this.world)
    this.player = Player:new(WINDOW_HEIGHT / 2, 100, this.world, ship)
    this.enemyGenerator = EnemyGenerator:new(this)

    this.pauseButton = Button:new(
        WINDOW_WIDTH - 50,
        0,
        'sprites/gui/buttons/pause.png',
        function()
            this.manager:switch_gui('pause')
        end
    )

    setmetatable(this, self)
    return this
end

function Map:update(dt)
    if self.player:is_dead() then
        self.manager:switch_gui('gameOver')
    else
        TIMER = TIMER + dt
        self.world:update(dt)
        self.player:update(dt)
        self.enemyGenerator:update(dt)
        updateLoop(dt, self.enemies)
    end
end

function Map:mousepressed(x, y)
    self.pauseButton:mousepressed(x, y)
end

function Map:draw()
    self.pauseButton:draw()
    self.player:draw()
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
