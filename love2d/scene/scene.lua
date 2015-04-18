
require "scene/CharacterPlayable"

local keyMoveUp     = "z"
local keyMoveDown   = "s"
local keyMoveLeft   = "q"
local keyMoveRight  = "d"
local keyThrowRight = "e"
local keyThrowLeft  = "a"

Scene = {
  triskelrangs = {},
  character = {}
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
    self.triskelrangs = {}
    self.character = CharacterPlayable:new()
    self.character:loadSprite()
    self.character:teleport(50,50)
end


function Scene:update(dt)    
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
    table.insert(self.triskelrangs, self.character:throw())
  end
end