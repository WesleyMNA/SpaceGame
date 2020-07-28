Pause = {}
Pause.__index = Pause

function Pause:new(background)
    local this = {
        class = 'Pause',

        background = background,
        icon = love.graphics.newImage('sprites/gui/map/pause.png')
    }

    local menuIcon = love.graphics.newImage('sprites/gui/buttons/menu.png')
    local menuX = (WINDOW_WIDTH / 2) - 100
    local menuY = WINDOW_HEIGHT / 2
    this.menuButton = Button:new(menuX, menuY, menuIcon)

    local playIcon = love.graphics.newImage('sprites/gui/buttons/play.png')
    local playX = WINDOW_WIDTH / 2 + 50
    local playY = WINDOW_HEIGHT / 2
    this.playButton = Button:new(playX, playY, playIcon)

    setmetatable(this, self)
    return this
end

function Pause:update(dt)
    function love.mousepressed(x, y)
        if CURRENT_GUI ~= 'pause' then return end

        if isClikingOnButton(self.playButton) then
            CURRENT_GUI = 'map'
        end

        if isClikingOnButton(self.menuButton) then
            CURRENT_GUI = 'menu'
        end
    end
end

function Pause:render()
    love.graphics.setColor(255, 255, 255, 0.3)
    love.graphics.draw(self.background)

    self.menuButton:render()
    self.playButton:render()

    local iconX = (WINDOW_WIDTH / 2) - self.icon:getWidth()/2
    local iconY = (WINDOW_HEIGHT / 2) - self.icon:getHeight()*1.5
    love.graphics.draw(self.icon, iconX, iconY)
end
