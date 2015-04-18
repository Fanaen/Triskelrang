
Character = {
  x = 0, 
  y = 0, 
  w = 25, 
  h = 45, 
  life = 100, 
  speed = 100
}

-- Constructors --
function Character:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

-- Methods --
function Character:draw ()
  love.graphics.setColorMask(0, 0, 100)
  love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

function Character:teleport(x, y)
  self.x = x
  self.y = y
end
