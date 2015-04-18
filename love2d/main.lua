-- Load some default values for our rectangle.
function love.load()
    x, y, w, h = 20, 20, 20, 20;
    triImage = love.graphics.newImage("images/triskelrang.png");
end

-- Increase the size of the rectangle every frame.
function love.update(dt)
    
end

-- Draw a coloured rectangle.
function love.draw()
    love.graphics.draw(triImage, x, y);
end