WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 256
VIRTUAL_HEIGHT = 144

TILE_SIZE = 16

CHARACTER_WIDTH = 16
CHARACTER_HEIGHT = 32

CHARACTER_MOVE_SPEED = 40
CAMERA_SCROLL_SPEED = 40

SKY = 37
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

  tileSheet = love.graphics.newImage('graphics/mainTileset.png')
  quads = GenerateQuads(tileSheet, TILE_SIZE, TILE_SIZE)

  characterSheet = love.graphics.newImage('graphics/mario.png')
  characterQuads = GenerateQuads(characterSheet, CHARACTER_WIDTH, CHARACTER_HEIGHT)

  characterX = VIRTUAL_WIDTH / 2 - (CHARACTER_WIDTH / 2)
  characterY = ((7 - 1) * TILE_SIZE) - (CHARACTER_HEIGHT * 2)

  mapWidth = 20
  mapHeight = 20

  backgroundR = math.random(255)
  backgroundG = math.random(255)
  backgroundB = math.random(255)

  cameraScroll = 0

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

function love.keypressed(key)
  if key == 'escape' then
      love.event.quit()
  end
end


function love.update(dt)

  gStateMachine:update(dt)

  love.keyboard.keysPressed = {}

  if love.keyboard.isDown('left') then
    characterX = characterX - CHARACTER_MOVE_SPEED * dt
  elseif love.keyboard.isDown('right') then
    characterX = characterX + CHARACTER_MOVE_SPEED * dt
  end

end

function love.draw()
  push:start()

  love.graphics.clear(backgroundR, backgroundG, backgroundB, 255)

  love.graphics.translate(math.floor(cameraScroll), 0)

  for y = 1, mapHeight do
    for x = 1, mapWidth do
      local tile = tiles[y][x]
      love.graphics.draw(tileSheet, quads[tile.id], (x - 1) * TILE_SIZE, (y - 1) * TILE_SIZE)
    end
  end

  love.graphics.draw(characterSheet, characterQuads[1], characterX, characterY)

  gStateMachine:render()

  push:finish()
end