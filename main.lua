WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 256
VIRTUAL_HEIGHT = 144

TILE_SIZE = 16

SKY = 2
GROUND = 1

require 'src/Dependencies'

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  love.window.setTitle('match 3')
  math.randomseed(os.time())
  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    vsync = true,
    fullscreen = false,
    resizable = true
  })

  tiles = {}

  tileset = love.graphics.newImage('graphics/mainTileset.png')
  quads = GenerateQuads(tileset, TILE_SIZE, TILE_SIZE)

  mapWidth = 20
  mapHeight = 20

  backgroundR = math.random(255)
  backgroundG = math.random(255)
  backgroundB = math.random(255)

  for y = 1, mapHeight do
    table.insert(tiles, {})

    for x = 1, mapWidth do
      table.insert(tiles[y], {
        id = y < 5 and SKY or GROUND
      })
    end
  end

  gStateMachine = StateMachine {
  }

  love.keyboard.keysPressed = {}
end

function love.resize(w, h)
  push:resize(w, h)
end

function love.keypressed(key)
  love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
  if love.keyboard.keysPressed[key] then
    return true
  else
    return false
  end
end


function love.update(dt)

  gStateMachine:update(dt)

  love.keyboard.keysPressed = {}
end

function love.draw()
  push:start()

  love.graphics.clear(backgroundR, backgroundG, backgroundB, 255)

  for y = 1, mapHeight do
    for x = 1, mapWidth do
      local tile = tiles[y][x]
      love.graphics.draw(tileset, quads[tile.id], (x - 1) * TILE_SIZE, (y - 1) * TILE_SIZE)
    end
  end


  gStateMachine:render()

  push:finish()
end