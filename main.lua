

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

  gStateMachine = StateMachine {
    ['start'] = function() return StartState() end,
    ['play'] = function() return PlayState() end
  }
  gStateMachine:change('start')


  tiles = {}

  tileSheet = love.graphics.newImage('graphics/mainTileset.png')
  quads = GenerateQuads(tileSheet, TILE_SIZE, TILE_SIZE)

  characterSheet = love.graphics.newImage('graphics/mario.png')
  characterQuads = GenerateQuads(characterSheet, CHARACTER_WIDTH, CHARACTER_HEIGHT)

  idleAnimation = Animation {
    frames = {1},
    interval = 1
  }
  movingAnimation = Animation {
    frames = {2, 3, 4},
    interval = 0.1
  }
  jumpAnimation = Animation {
    frames = {6},
    interval = 1
  }

  currentAnimation = idleAnimation

  characterX = VIRTUAL_WIDTH / 2 - (CHARACTER_WIDTH / 2)
  characterY = ((7 - 1) * TILE_SIZE) - (CHARACTER_HEIGHT * 2)

  characterDY = 0
  direction = 'right'

  mapWidth = 50
  mapHeight = 20

  backgroundR = math.random(255)
  backgroundG = math.random(255)
  backgroundB = math.random(255)

  cameraScroll = 0

  -- for y = 1, mapHeight do
  --   table.insert(tiles, {})

  --   for x = 1, mapWidth do
  --     table.insert(tiles[y], {
  --       id = y < 7 and SKY or GROUND
  --     })
  --   end
  -- end

  -- tiles = generateLevel()


  gStateMachine = StateMachine {
    ['start'] = function() return StartState() end,
    ['play'] = function() return PlayState() end,
  }
  gStateMachine:change('start')

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
  if key == 'space' and characterDY == 0 then
    characterDY = JUMP_VELOCITY
    currentAnimation = jumpAnimation
  end
end


function love.update(dt)
  gStateMachine:update(dt)
  love.keyboard.keysPressed = {}

--   characterDY = characterDY + GRAVITY
--   characterY = characterY + characterDY * dt

--   if characterY > ((8 - 1) * TILE_SIZE) - CHARACTER_HEIGHT then
--     characterY = ((8 - 1) * TILE_SIZE) - CHARACTER_HEIGHT
--     characterDY = 0
--   end

--   currentAnimation:update(dt)

--   if love.keyboard.isDown('left') then
--     characterX = characterX - CHARACTER_MOVE_SPEED * dt
--     if characterDY == 0 then
--         currentAnimation = movingAnimation
--     end
--     direction = 'left'
--   elseif love.keyboard.isDown('right') then
--     characterX = characterX + CHARACTER_MOVE_SPEED * dt
--     if characterDY == 0 then
--       currentAnimation = movingAnimation
--     end
--     direction = 'right'
--   elseif characterDY == 0 then
--     currentAnimation = idleAnimation
--   else
--     currentAnimation = jumpAnimation
--   end
-- cameraScroll = characterX - (VIRTUAL_WIDTH / 2) + (CHARACTER_WIDTH / 2)

end

function love.draw()
  push:start()
  
  -- love.graphics.clear(backgroundR, backgroundG, backgroundB, 255)

  -- love.graphics.translate(math.floor(-cameraScroll), 0)

  -- for y = 1, mapHeight do
  --   for x = 1, mapWidth do
  --     local tile = tiles[y][x]
  --     love.graphics.draw(tileSheet, quads[tile.id], (x - 1) * TILE_SIZE, (y - 1) * TILE_SIZE)
  --   end
  -- end

  -- love.graphics.draw(characterSheet, characterQuads[currentAnimation:getCurrentFrame()], 
  --   math.floor(characterX) + CHARACTER_WIDTH / 2, math.floor(characterY) + CHARACTER_HEIGHT / 2, 
  --   0, direction == 'left' and -1 or 1, 1,
  --   CHARACTER_WIDTH / 2, CHARACTER_HEIGHT / 2)

  gStateMachine:render()
  push:finish()
end

-- function generateLevel()
--   local tiles = {}

--   for y = 1, mapHeight do
--       table.insert(tiles, {})

--       for x = 1, mapWidth do
--           table.insert(tiles[y], {
--               id = SKY,
--           })
--       end
--   end

--   for x = 1, mapWidth do
--     if math.random(7) == 1 then
--       goto continue
--     end

--     local spawnPillar = math.random(5) == 1
    
--     if spawnPillar then
--       for pillar = math.random(5,7), 7 do
--         tiles[pillar][x] = {
--           id = CHOC,
--         }
--       end
--     end

--     for ground = 8, mapHeight do
--       tiles[ground][x] = {
--         id = GROUND,
--       }
--     end

--     ::continue::

--   end

--   return tiles
-- end