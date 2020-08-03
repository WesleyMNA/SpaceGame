local saveData = require('libs/saveData')

FILE = 'data'

function getActivatedShips()
    local ships = {}
    for i=1,6 do
        if SHIPS_DATA[i].activated then
            ships[i] = SHIPS_DATA[i].id
        end
    end
    return ships
end

function save()
    local data = {}
    data.points = POINTS
    data.record = RECORD
    data.activatedShips = getActivatedShips()

    saveData.save(data, FILE)
end

function load()
    local data = saveData.load(FILE)
    POINTS = data.points
    RECORD = data.record
    for i, id in pairs(data.activatedShips) do 
        SHIPS_DATA[id].activated = true
    end
end
