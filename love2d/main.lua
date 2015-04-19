
require "level/Tutorial"

-- Methods --
levels = {}
levelIndex = -1

function love.load()
  -- Levels declaration --
  levels[0] = LevelTutorial:new()
  levels[0]:load()
  levelIndex = 0
  
  -- Levels initialisation --
  for key, level in ipairs(levels) do -- TODO Fix this
    level:load()
  end
end

function love.update(dt)
  -- Update the current level's state --
  if levelIndex ~= -1 then
    levels[levelIndex]:update(dt)
  end
end

function love.draw()
  -- Draw the current level's state --
  if levelIndex ~= -1 then
    levels[levelIndex]:draw()
  end
end

-- Events --

function love.keypressed(key)
  -- Global binding - Next level --
  if key == "n" and levelIndex < table.getn(levels) then 
    levelIndex = levelIndex + 1
    
  -- Global binding - Previous level -- 
  elseif key == "p" and levelIndex > 0 then 
    levelIndex = levelIndex - 1
    
  -- Specific binding - Transfer event to the level -- 
  elseif levelIndex ~= -1 then
    levels[levelIndex]:keypressed(key)
  end
end

function love.mousepressed(x, y, button)

  -- Specific binding - Transfer event to the level -- 
  if levelIndex ~= -1 then
    levels[levelIndex]:mousepressed(x, y, button)
  end
end