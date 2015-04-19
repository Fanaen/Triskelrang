------------------------
-- Abstract Character --
------------------------

Character = {
  x = 0, 
  y = 0, 
  w = 25, 
  h = 43, 
  life = 100, 
  speed = 100,
  drawable = nil,
  world = {},
  body = {},
  shape = {},
  fixture = {}
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

function Character:loadPhysic(world)
  self.world = world
  -- self.body = love.physics.newBody(world, self.x, self.y, "dynamic")
  -- self.shape = love.physics.newCircleShape(10)
  -- self.fixture = love.physics.newFixture(self.body, self.shape, 2)
end

