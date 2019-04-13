Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/StateMachine'
require 'src/states/BaseState'
require 'src/states/game/StartState'
require 'src/states/game/PlayState'

require 'src/constants'
require 'src/Util'
require 'src/Animation'
require 'src/TileMap'
require 'src/GameObject'
require 'src/LevelMaker'
require 'src/GameLevel'

require 'src/Entity'
require 'src/Player'
require 'src/Goomba'
require 'src/Tile'



gSounds = {}

gTextures = {}

gFrames = {}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32)
}