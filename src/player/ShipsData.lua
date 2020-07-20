SHIPS_DATA = {}

SHIPS_DATA[1] = {
    number = 1,
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
            yoffset = 32
        }
    }
}

SHIPS_DATA[2] = {
    number = 2,
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
            yoffset = 64
        }
    }
}