
require "scene/Character"

Enemy = Character:new()

-- Constructors --

function Enemy:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

-- Methods --