
require "scene/scene"

Level = Scene:new()

-- Constructors --

function Level:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Level:load()
  self:loadPhysic()
  self.player = self:loadCharacter()
  
  self:setCharacters()
end

function Level:setCharacters() end

-- Methods --

function Level:addPNG(enemy, x, y) 
  self:loadCharacter(enemy)
  enemy:teleport(x, y)
  
  table.insert(self.enemies,enemy)
end