SHIPS_DATA = {}

SHIPS_DATA[1] = {
    id = 1,
    activated = true,
    sprite = love.graphics.newImage('sprites/player/ship1/ship.png'),
    price = 0,
    health = 1,
    speed = 200,
    radius = 17,
    shotSpeed = 0.25,
    shotX = 55,
    shotY = 0,
    shot = {
        width = 32,
        height = 32,
        speed = 300,
        radius = 3,
        sound = love.audio.newSource('sounds/player/ship1/shot.wav', 'static'),
        move = {
            fps = 10,
            frames = 5,
            xoffsetMul = 32,
            yoffset = 0
        },
        collide = {
            fps = 10,
            frames = 5,
            xoffsetMul = 32,
            yoffset = 32,
            class = 'Ignore'
        }
    }
}

SHIPS_DATA[2] = {
    id = 2,
    activated = false,
    sprite = love.graphics.newImage('sprites/player/ship2/ship.png'),
    price = 10000,
    health = 5,
    speed = 250,
    radius = 20,
    shotSpeed = 0.2,
    shotX = 55,
    shotY = -15,
    shot = {
        width = 64,
        height = 64,
        speed = 300,
        radius = 6,
        sound = love.audio.newSource('sounds/player/ship2/shot.wav', 'static'),
        move = {
            fps = 100,
            frames = 7,
            xoffsetMul = 64,
            yoffset = 0
        },
        collide = {
            fps = 10,
            frames = 5,
            xoffsetMul = 64,
            yoffset = 64,
            class = 'Ignore'
        }
    }
}

SHIPS_DATA[3] = {
    id = 3,
    activated = false,
    sprite = love.graphics.newImage('sprites/player/ship3/ship.png'),
    price = 20000,
    health = 5,
    speed = 300,
    radius = 20,
    shotSpeed = 0.3,
    shotX = 75,
    shotY = -10,
    shot = {
        width = 64,
        height = 64,
        speed = 200,
        radius = 7,
        sound = love.audio.newSource('sounds/player/ship3/shot.wav', 'static'),
        move = {
            fps = 10,
            frames = 4,
            xoffsetMul = 64,
            yoffset = 0
        },
        collide = {
            fps = 10,
            frames = 4,
            xoffsetMul = 64,
            yoffset = 64,
            class = 'Shot'
        }
    }
}

SHIPS_DATA[4] = {
    id = 4,
    activated = false,
    sprite = love.graphics.newImage('sprites/player/ship4/ship.png'),
    price = 40000,
    health = 10,
    speed = 400,
    radius = 21,
    shotSpeed = 0.155,
    shotX = 80,
    shotY = -5,
    shot = {
        width = 64,
        height = 64,
        speed = 300,
        radius = 3,
        sound = love.audio.newSource('sounds/player/ship4/shot.wav', 'static'),
        move = {
            fps = 100,
            frames = 6,
            xoffsetMul = 64,
            yoffset = 0
        },
        collide = {
            fps = 10,
            frames = 8,
            xoffsetMul = 64,
            yoffset = 64,
            class = 'Ignore'
        }
    }
}

SHIPS_DATA[5] = {
    id = 5,
    activated = false,
    sprite = love.graphics.newImage('sprites/player/ship5/ship.png'),
    price = 80000,
    health = 10,
    speed = 400,
    radius = 26,
    shotSpeed = 0.3,
    shotX = 75,
    shotY = 5,
    shot = {
        width = 64,
        height = 64,
        speed = 300,
        radius = 6,
        sound = love.audio.newSource('sounds/player/ship5/shot.wav', 'static'),
        move = {
            fps = 100,
            frames = 6,
            xoffsetMul = 64,
            yoffset = 0
        },
        collide = {
            fps = 10,
            frames = 8,
            xoffsetMul = 64,
            yoffset = 64,
            class = 'Shot'
        }
    }
}

SHIPS_DATA[6] = {
    id = 6,
    activated = false,
    sprite = love.graphics.newImage('sprites/player/ship6/ship.png'),
    price = 100000,
    health = 20,
    speed = 500,
    radius = 30,
    shotSpeed = 0.1,
    shotX = 85,
    shotY = 4,
    shot = {
        width = 64,
        height = 64,
        speed = 300,
        radius = 5,
        sound = love.audio.newSource('sounds/player/ship6/shot.wav', 'static'),
        move = {
            fps = 100,
            frames = 5,
            xoffsetMul = 64,
            yoffset = 0
        },
        collide = {
            fps = 10,
            frames = 10,
            xoffsetMul = 64,
            yoffset = 64,
            class = 'Shot'
        }
    }
}
