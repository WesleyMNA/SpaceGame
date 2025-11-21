local tile = {}

tile.size = 64

function tile.to_tile_size(pixel_point)
    return pixel_point * tile.size
end

return tile
