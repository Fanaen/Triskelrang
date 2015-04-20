
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
  persisting = 0
end

function Scene:loadPhysic()
  love.physics.setMeter(27) -- the height of a meter our worlds will be 64px
  self.world = love.physics.newWorld(0, 0, true)
  self.world:setCallbacks(beginContact, endContact, preSolve, postSolve)
end

-- CALLBACKS --
function beginContact(a, b, coll)
    local x,y = coll:getNormal()
    local aObject, bObject = a:getUserData(),  b:getUserData()
    
    
    if aObject.className == "Triskelrang" then
      aObject.circleSpeed = - aObject.circleSpeed
    end
    if bObject.className == "Triskelrang" then
      bObject.circleSpeed = - bObject.circleSpeed
    end
    
    print(aObject.className.." colliding with ".. bObject.className.." with a vector normal of: "..x..", "..y)
end

function endContact(a, b, coll)
    --persisting = 0
    --print(a:getUserData().." uncolliding with "..b:getUserData())
end

function preSolve(a, b, coll)
    --if persisting == 0 then    -- only say when they first start touching
        --print(a:getUserData().." touching "..b:getUserData())
    --elseif persisting < 20 then    -- then just start counting
    --    print(" "..persisting)
    --end
    --persisting = persisting + 1    -- keep track of how many updates they've been touching for
end

function postSolve(a, b, coll, normalimpulse1, tangentimpulse1, normalimpulse2, tangentimpulse2)
end
-- CALLBACKS --

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
    
    love.graphics.print(text, 10, 10)
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