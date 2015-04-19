
require "scene/scene"

Level = Scene:new()
Level.background = nil
Level.walls = {}

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
  self:setMap()
end

function Level:setCharacters() end
function Level:setMap() end

function Scene:draw()
    love.graphics.draw(self.background)
    
    self.player:draw()
    self:drawArray(self.triskelrangs)
    self:drawArray(self.enemies)
end

-- Methods --

function Level:addPNG(enemy, x, y) 
  self:loadCharacter(enemy)
  enemy:teleport(x, y)
  
  table.insert(self.enemies,enemy)
end


function Level:loadBackground(location) 
  self.background = love.graphics.newImage(location)
end