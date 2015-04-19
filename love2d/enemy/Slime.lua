
require "scene/Character"

SlimeDefault = Character:new()

-- Constructors --

function SlimeDefault:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

-- Methods --

function SlimeDefault:config()
  self.life = 25
  self.w, self.h = 32, 26
  
  -- A-B-C-B pattern -- 
  local walkMapping = {}
  walkMapping[0] = 0
  walkMapping[1] = 1
  walkMapping[2] = 2
  walkMapping[3] = 1
  self.walkStateNb = 3
  
  self:loadSprite("images/slime.png", 1, walkMapping) -- 1 directions --
end

function SlimeDefault:update(dt)
  self:updateState(dt)
  self:updateSprite()
end

function SlimeDefault:updateState(dt)
  self.walkTime = self.walkTime + dt
  
  if(self.walkTime > 0.25) then
    self.walkTime = self.walkTime - 0.25
    self:nextWalkState()
  end
end