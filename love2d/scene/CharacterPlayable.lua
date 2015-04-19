------------------------
-- Playable Character --
------------------------

require "scene/Character"
require "scene/Triskelrang"

CharacterPlayable = Character:new()

function CharacterPlayable:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function CharacterPlayable:config()
  self.life = 100
  self.w, self.h = 25, 43
  
  -- A-B-A-C pattern -- 
  local walkMapping = {}
  walkMapping[0] = 0
  walkMapping[1] = 1
  walkMapping[2] = 0
  walkMapping[3] = 2
  self.walkStateNb = 3
  
  self:loadSprite("images/druid.png", 4, walkMapping) -- 4 directions --  
end

function CharacterPlayable:mapDirection(horizontal, vertical)  
  if      vertical == 1    then return 0 -- Down
  elseif  vertical == -1   then return 2 -- Top
  elseif  horizontal == 1  then return 3 -- Right
  elseif  horizontal == -1 then return 1 -- Left
  end
end

function CharacterPlayable:updateState(dt)
  self.walkTime = self.walkTime + dt
  
  if(self.walkTime > 0.25) then
    self.walkTime = self.walkTime - 0.25
    self:nextWalkState()
  end
end

function CharacterPlayable:throw(hand, mouse)
  local triskelrang = Triskelrang:new()
  
  triskelrang.x = self.x + (self.w/2) -- + (self.horizontal * self.w)
  triskelrang.y = self.y + (self.h/2) -- + (self.vertical * self.h)
  
  -- Custom physic --
  -- triskelrang.speedx = triskelrang.speedx * self.horizontal
  -- triskelrang.speedy = triskelrang.speedy * self.vertical
  
  -- Box2D Physic --
  triskelrang:loadPhysic(self.world)
  triskelrang.body:applyLinearImpulse(self.horizontal * 300, self.vertical * 300)
  
  return triskelrang
end
