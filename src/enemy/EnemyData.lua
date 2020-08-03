ENEMY_DATA = {}

ENEMY_DATA.smallEnemy = {
    spritesheet = love.graphics.newImage('sprites/enemy/enemy-small.png'),
    health = 1,
    diePoints = 10,
    shotSpeed = 1
}

ENEMY_DATA.mediumEnemy = {
    spritesheet = love.graphics.newImage('sprites/enemy/enemy-medium.png'),
    health = 2,
    diePoints = 20,
    shotSpeed = 0.5
}

ENEMY_DATA.bigEnemy = {
    spritesheet = love.graphics.newImage('sprites/enemy/enemy-big.png'),
    health = 5,
    diePoints = 50,
    shotSpeed = 0.25
}