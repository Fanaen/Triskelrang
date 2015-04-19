
-------------------
--  Declaration  --
-------------------

require "scene/CharacterPlayable"

local keyMoveUp     = "z"
local keyMoveDown   = "s"
local keyMoveLeft   = "q"
local keyMoveRight  = "d"
local keyThrowRight = "e"
local keyThrowLeft  = "a"

Scene = {
  triskelrangs = {},
  enemies = {},
  character = {},
  world = {}
}

function Scene:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

---------------
--  Loading  --
---------------

function Scene:load()
  self:loadPhysic()
  self.player = self:loadCharacter()
end

function Scene:loadPhysic()
  love.physics.setMeter(27) -- the height of a meter our worlds will be 64px
  self.world = love.physics.newWorld(0, 0, true)
end

function Scene:loadCharacter(character)
  local character = character or CharacterPlayable:new()
  character:load()
  character:loadPhysic(self.world)
  return character
end

----------------
--  Updating  --
----------------

function Scene:update(dt)
  -- Box2D --
  self.world:update(dt)
  
  -- Character --
  self:updateCharacter(dt, self.player)
  
  -- Other objects --
  self:updateArray(self.triskelrangs, dt)
  self:updateArray(self.enemies, dt)
end

function Scene:updateCharacter(dt, character)
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
  character:move(dt, horizontal, vertical)
end

function Scene:updateArray(array, dt)
  for key, item in ipairs(array) do
    item:update(dt)
  end
end

---------------
--  Drawing  --
---------------

function Scene:draw()

    self.player:draw()
    self:drawArray(self.triskelrangs)
    self:drawArray(self.enemies)
end

function Scene:drawArray(array)
  for key, item in ipairs(array) do
    item:draw()
  end
end

--------------
--  Events  --
--------------

function Scene:keypressed(key)
  if key == keyThrowRight or key == keyThrowLeft then
    local hand = "right"
    if key == keyThrowLeft then hand = "left" end 
    
    table.insert(self.triskelrangs, self.player:throw(hand))
  end
end

function Scene:mousepressed(x, y, button)
  local hand, mouse = "right", {x = x, y = y}
  table.insert(self.triskelrangs, self.player:throw(hand, mouse))
end