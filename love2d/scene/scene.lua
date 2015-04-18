
require "scene/Character"

scene = {}

function scene.load()
    x, y, w, h = 20, 20, 20, 20
    rotation = 0
    triImage = love.graphics.newImage("images/triskelrang.png")
    
    character = Character:new()
    character:teleport(50,50)
end


function scene.update(dt)
    x = x + (dt * 50)
    rotation = rotation + (math.pi * 3 * dt)
end

function scene.draw()
    love.graphics.draw(triImage, x, y, rotation, 1, 1, triImage:getHeight()/2, triImage:getWidth()/2)
    character:draw()
end