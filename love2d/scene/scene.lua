
require "scene/CharacterPlayable"

local keyMoveUp     = "z"
local keyMoveDown   = "s"
local keyMoveLeft   = "q"
local keyMoveRight  = "d"
local keyThrowRight = "e"
local keyThrowLeft  = "a"

Scene = {
  triskelrangs = {},
  character = {},
  world = {}
}

-- Constructors --
function Scene:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

-- Methods --
function Scene:load()
    love.physics.setMeter(27) -- the height of a meter our worlds will be 64px
    self.world = love.physics.newWorld(0, 0, true)
    
    self.triskelrangs = {}
    self.character = CharacterPlayable:new()
    self.character:loadSprite()
    self.character:loadPhysic(self.world)
    self.character:teleport(50,50)
end


function Scene:update(dt)
    -- Box2D --  
    self.world:update(dt)
    
    -- Keyboard management --
    local horizontal, vertical = 0, 0
    
    -- Horizontal --
    if love.keyboard.isDown(keyMoveLeft) then
      horizontal = -1
    elseif love.keyboard.isDown(keyMoveRight) then
      horizontal = 1
    end
    
    -- Vertical --
    if love.keyboard.isDown(keyMoveUp) then
      vertical = -1
    elseif love.keyboard.isDown(keyMoveDown) then
      vertical = 1
    end
    
    -- Update character --
    self.character:move(dt, horizontal, vertical)
    
    -- Update Triskelrangs --
    for key, triskelrang in ipairs(self.triskelrangs) do
      triskelrang:update(dt)
    end
end

function Scene:draw()

    self.character:draw()
    
    for key, triskelrang in ipairs(self.triskelrangs) do
      triskelrang:draw()
    end
end

function Scene:keypressed(key)
  if key == keyThrowRight or key == keyThrowLeft then
    local hand = "right"
    if key == keyThrowLeft then hand = "left" end 
    
    table.insert(self.triskelrangs, self.character:throw(hand))
  end
end

function Scene:mousepressed(x, y, button)
  local hand, mouse = "right", {x = x, y = y}
  table.insert(self.triskelrangs, self.character:throw(hand, mouse))
end