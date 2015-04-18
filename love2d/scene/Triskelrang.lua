------------------------
-- Abstract Character --
------------------------

Triskelrang = {
  x = 0, 
  y = 0, 
  w = 25, 
  h = 45,
  rotation = 0,
  life = 100, 
  speedx = 100,
  speedy = 100,
  image = nil
}

-- Constructors --
function Triskelrang:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  
  self.image = love.graphics.newImage("images/triskelrang.png")
  self.h = self.image:getHeight()
  self.w = self.image:getWidth()
  
  return o
end

-- Methods --

function Triskelrang:update (dt)
  self.x = self.x + (self.speedx * dt)
  self.y = self.y + (self.speedy * dt)
  self.rotation = self.rotation + (math.pi * 3 * dt)
end

function Triskelrang:draw ()
  love.graphics.draw(self.image, self.x, self.y, self.rotation, 1, 1, self.w/2, self.h/2)
end

