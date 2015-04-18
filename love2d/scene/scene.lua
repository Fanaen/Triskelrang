
require "scene/Character"

scene = {}

local keyMoveUp     = "z"
local keyMoveDown   = "s"
local keyMoveLeft   = "q"
local keyMoveRight  = "d"

function scene.load()
    x, y, w, h = 20, 20, 20, 20
    rotation = 0
    triImage = love.graphics.newImage("images/triskelrang.png")
    
    character = CharacterPlayable:new()
    character:loadSprite()
    character:teleport(50,50)
end


function scene.update(dt)
    x = x + (dt * 50)
    rotation = rotation + (math.pi * 3 * dt)
    
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
    
    character:move(dt, horizontal, vertical)
end

function scene.draw()
    love.graphics.draw(triImage, x, y, rotation, 1, 1, triImage:getHeight()/2, triImage:getWidth()/2)
    character:draw()
end