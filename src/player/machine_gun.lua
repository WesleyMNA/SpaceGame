require('src.player.Shot')

local game = require('src.utils.game')

MachineGun = {}
MachineGun.__index = MachineGun

function MachineGun:new(world, player, shot_data)
    local this = {
        _world = world,
        _player = player,
        _shot_data = shot_data,
        _shots = {},

        _offset_x = shot_data.offset_x,
        _offset_y = shot_data.offset_y,
    }

    this._fire_speed = shot_data.fire_speed
    this._shot_timer = this._fire_speed

    setmetatable(this, self)
    return this
end

function MachineGun:update(dt)
    self:_fire(dt)
    game.update(self._shots, dt)
end

function MachineGun:_fire(dt)
    self._shot_timer = self._shot_timer + dt

    if self._shot_timer > self._fire_speed then
        self:_create_shot()
        self._shot_timer = 0
    end
end

function MachineGun:_create_shot()
    local player_x, player_y = self._player:getPosition()
    local shot = Shot:new(
        player_x + self._offset_x,
        player_y + self._offset_y,
        self._player.current_ship,
        self._world,
        self._shots
    )
    love.audio.play(self._shot_data.sound)
    table.insert(self._shots, shot)
end

function MachineGun:draw()
    game.draw(self._shots)
end
