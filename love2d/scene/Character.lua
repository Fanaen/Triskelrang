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
  local atlas = love.graphics.newImage("images/druiddown.png")
  local tileWidth, tileHeight = 25, 43
  local spriteBatch = love.graphics.newSpriteBatch(atlas, 3)
  
  -- Init sprites
  self.quads = {}
  self.quads[0] = love.graphics.newQuad(0, 0, 25, 43, atlas:getWidth(), atlas:getHeight())
  self.quads[1] = love.graphics.newQuad(25, 0, 25, 43, atlas:getWidth(), atlas:getHeight())
  self.quads[2] = love.graphics.newQuad(0, 0, 25, 43, atlas:getWidth(), atlas:getHeight())
  self.quads[3] = love.graphics.newQuad(50, 0, 25, 43, atlas:getWidth(), atlas:getHeight())
  
  -- Init other values --
  self.drawable = spriteBatch
  self.time = 0
  self.state = 0
end

function CharacterPlayable:update(dt)
  self.time = self.time + dt
  
  if(self.time > 0.25) then
    self.time = self.time - 0.25
    
    -- Next state --
    if(self.state < 3) then
      self.state = self.state + 1
    else
      self.state = 0
    end
    
    self.drawable:clear()
    self.drawable:add(self.quads[self.state])
  end
  
end

function CharacterPlayable:draw()
  love.graphics.draw(self.drawable, self.x, self.y)
end
