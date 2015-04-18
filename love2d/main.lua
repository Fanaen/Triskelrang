
require "scene/scene"

function love.load()
  scene = Scene:new()
  scene:load()
end

function love.update(dt)
  scene:update(dt)
end

function love.draw()
  scene:draw()
end

function love.keypressed(key)
  scene:keypressed(key)
end