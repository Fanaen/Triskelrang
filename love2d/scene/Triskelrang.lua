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
  hand = "right",
  speedx = 100,
  speedy = 100,
  image = nil,
  body = {},
  shape = {},
  fixture = {}
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

function Triskelrang:loadPhysic(world)
  self.body = love.physics.newBody(world, self.x, self.y, "dynamic")
  self.shape = love.physics.newCircleShape(12)
  self.fixture = love.physics.newFixture(self.body, self.shape, 2)
end

-- Methods --
function Triskelrang:update(dt)
  -- Custom physic --
  -- self.x = self.x + (self.speedx * dt)
  -- self.y = self.y + (self.speedy * dt)
  self.rotation = self.rotation + (math.pi * 3 * dt)
  
  local x, y = self.body:getLinearVelocity()
  if self.hand == "right" then
    self.body:applyForce(-y*2, x*2)
  elseif self.hand == "left" then
    self.body:applyForce(y*2, -x*2)
  end
  
  -- Box 2D physic --
  
end

function Triskelrang:draw ()
  --love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
  love.graphics.draw(self.image, self.body:getX(), self.body:getY(), self.rotation, 1, 1, self.w/2, self.h/2)
end

