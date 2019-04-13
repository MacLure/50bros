LevelMaker = Class{}
function LevelMaker.generate(width, height)
  local tiles = {}
  local entities = {}
  local objects = {}
  local tileID = TILE_ID_GROUND

  for x = 1, height do
    table.insert(tiles, {})
  end

  for x = 1, width do
    local tileID = TILE_ID_EMPTY

    for y = 1, 6 do
      table.insert(tiles[y], Tile(x, y, tileID, nil, tileset))
    end

    if math.random(7) == 1 then
      for y = 7, height do
        table.insert(tiles[y],Tile(x, y, tileID, nil, tileset))
      end
    else
      tileID = TILE_ID_GROUND
      local blockheight = 4

      for y = 7, height do
        table.insert(tiles[y], Tile(x, y, tileID, tileset))
      end

      if math.random(8) == 1 then
        blockHeight = 2

        tiles[5][x] = Tile(x, 5, tileID, tileset)
        tiles[6][x] = Tile(x, 6, tileID, tileset)
      end
    end
  end

  local map = TileMap(width, height)
  map.tiles = tiles
  return GameLevel(entities, objects, map)
end
