--------------------
-- Abstract class --
--------------------

Character = {
  x = 0, 
  y = 0, 
  w = 25, 
  h = 45, 
  life = 100, 
  speed = 100,
  drawable = nil
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
  
  if self.drawable == nil then
  else
    love.graphics.draw(self.drawable,self.x,self.y)
  end
end

function Character:teleport(x, y)
  self.x = x
  self.y = y
end

------------------------
-- Playable Character --
------------------------

CharacterPlayable = Character:new()

function CharacterPlayable:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function CharacterPlayable:loadSprite()
  -- Init sprite batch --
  local atlas = love.graphics.newImage("images/druid.png")
  local tileWidth, tileHeight = 25, 43
  local spriteBatch = love.graphics.newSpriteBatch(atlas, 3)
  
  -- Store A-B-A-C pattern -- 
  local walkMapping = {}
  walkMapping[0] = 0
  walkMapping[1] = 1
  walkMapping[2] = 0
  walkMapping[3] = 2
  
  -- Init sprites
  self.quads = {}
  for dir = 0, 3 do
    self.quads[dir] = {}
    
    for walk = 0, table.getn(walkMapping) do
      self.quads[dir][walk] = love.graphics.newQuad(
        walkMapping[walk] * tileWidth,  -- x
        dir * tileHeight,               -- y
        tileWidth,                      -- Sprite width
        tileHeight,                     -- Sprite height
        atlas:getWidth(),               -- Atlas width
        atlas:getHeight())              -- Atlas height 
    end
  end
  
  -- Init other values --
  self.drawable = spriteBatch
  self.time = 0
  self.state = 0
  self.dir = 0
  self.drawable:add(self.quads[self.dir][self.state])
end

function CharacterPlayable:updateDirection(horizontal, vertical)
  if vertical == 1 then -- Down
    self.dir = 0
  elseif vertical == -1 then -- Top
    self.dir = 2
  elseif horizontal == 1 then -- Left
    self.dir = 3
  elseif horizontal == -1 then -- Left
    self.dir = 1
  end
end

function CharacterPlayable:updateState(dt)
  self.time = self.time + dt
  
  if(self.time > 0.25) then
    self.time = self.time - 0.25
    
    -- Next state --
    if(self.state < 3) then
      self.state = self.state + 1
    else
      self.state = 0
    end
  end
end

function CharacterPlayable:updateSprite()
  print(self.dir)
  self.drawable:clear()
  self.drawable:add(self.quads[self.dir][self.state])
end

function CharacterPlayable:move(dt, horizontal, vertical)
  
  self:updateDirection(horizontal, vertical)
  
  -- Update the sprite --
  if horizontal ~= 0 or vertical ~= 0 then
    self:updateState(dt)
  end
  
  self:updateSprite()
  
  -- Move the character --
  self.x = self.x + (horizontal * dt * self.speed)
  self.y = self.y + (vertical * dt * self.speed)
end

function CharacterPlayable:draw()
  love.graphics.draw(self.drawable, self.x, self.y)
end
