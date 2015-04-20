------------------------
-- Abstract Character --
------------------------

Character = {
  x           = 0, 
  y           = 0, 
  w           = 25, 
  h           = 43, 
  life        = 100, 
  speed       = 100,
  walkTime    = 0,
  walkState   = 0,
  walkStateNb = 1,
  walkDir     = 0,
  horizontal  = 0,
  vertical    = 1,
  drawable    = nil,
  world       = {},
  body        = {},
  shape       = {},
  fixture     = {}
}

-- Constructors --
function Character:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

---------------
--  Loading  --
---------------

function Character:load()
  self:config()
end

function Character:config() end

function Character:loadSprite(location, dirnumber, walkMapping)
  -- Init sprite batch --
  local atlas = love.graphics.newImage(location)
  atlas:setFilter("nearest", "linear") -- this "linear filter" removes some artifacts if we were to scale the tiles
  local spriteBatch = love.graphics.newSpriteBatch(atlas)
  
  -- Init sprites
  self.quads = {}
  for dir = 0, dirnumber - 1 do
    self.quads[dir] = {}
        
    for walk = 0, table.getn(walkMapping) do
      self.quads[dir][walk] = love.graphics.newQuad(
        walkMapping[walk] * self.w,     -- x
        dir * self.h,                   -- y
        self.w,                         -- Sprite width
        self.h,                         -- Sprite height
        atlas:getWidth(),               -- Atlas width
        atlas:getHeight())              -- Atlas height 
    end
  end
  
  -- Init other values --
  self.drawable = spriteBatch
  self.drawable:add(self.quads[self.walkDir][self.walkState])
end


----------------
--  Updating  --
----------------

-- Overridable --

function Character:update(dt) end

function Character:mapDirection(horizontal, vertical)
  return 0
end

function Character:updateState(dt) end

function Character:updateSprite()
  if self.drawable ~= nil then
    self.drawable:clear()
    self.drawable:add(self.quads[self.walkDir][self.walkState])
  end
end

-- Generic --

function Character:move(dt, horizontal, vertical)
  
  
  -- Update the sprite --
  if horizontal ~= 0 or vertical ~= 0 then
    self.horizontal = horizontal
    self.vertical = vertical
    self:updateState(dt)
    self.walkDir = self:mapDirection(horizontal, vertical)
  end
  
  self:updateSprite()
  
  -- Move the character --
  self.x = self.x + (horizontal * dt * self.speed)
  self.y = self.y + (vertical * dt * self.speed)
  --self.body:setX(self.x + (self.w / 2))
  --self.body:setY(self.y + (self.h / 2))
end

function Character:teleport(x, y)
  self.x = x
  self.y = y
  --self.body:setX(self.x + (self.w / 2))
  --self.body:setY(self.y + (self.h / 2))
end

function Character:nextWalkState()
  if(self.walkState < self.walkStateNb) then
    self.walkState = self.walkState + 1
  else
    self.walkState = 0
  end
end

---------------
--  Drawing  --
---------------

function Character:draw()
  if self.drawable == nil then
    love.graphics.setColorMask(0, 0, 100)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
  else
    --love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
    love.graphics.draw(self.drawable, self.x, self.y)
  end
end

function Character:loadPhysic(world)
  self.world = world
  --self.body = love.physics.newBody(world, self.x, self.y, "dynamic")
  --self.body:setFixedRotation(true)
  --self.shape = love.physics.newRectangleShape(0, 0, self.w, self.h)
  --self.fixture = love.physics.newFixture(self.body, self.shape, 20)
end

