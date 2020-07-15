function createCollisionClasses(world)
    world:addCollisionClass('Player')
    world:addCollisionClass('Shot')
    world:addCollisionClass('Enemy')
    world:addCollisionClass('EnemyShot')
    world:addCollisionClass('Ignore')

    --world:addCollisionClass('')
end