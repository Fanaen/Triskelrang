
require "level/Level"
require "enemy/Slime"

LevelTutorial = Level:new()

-- Constructors --

function LevelTutorial:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

-- Methods --

function LevelTutorial:setCharacters() 
  
  -- Initial player's location --
  self.player:teleport(50, 50)
  
  -- Add monsters --
  self:addPNG(SlimeDefault:new(), 400, 400)
  
end

function LevelTutorial:setMap()
  
  -- Background --
  self:loadBackground("images/text1.png")
  
  
end