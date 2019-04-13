Tile = Class{}

function Tile:init(x, y, id)
  self.x = x
  self.y = y
  self.width = TILE_SIZE
  self.height = TILE_SIZE
  self.id = id
end

function Tile:collidable(target)
  for k, v in pairs(COLLIDABLE_TILES) do
    if v == self.id then
      return true
    end

    return false
  end

  function Tile:render()
    love.graphics.draw(gTextures['tiles'], quads[tile.id], (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)

  end
end
