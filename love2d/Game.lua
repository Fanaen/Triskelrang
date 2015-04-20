local Game = fg.Object:extend('Game')

Player = require('characters/Player')
require('characters/Slime')


function Game:new()
    fg.debugDraw.physics_enabled = true
    fg.setScreenSize(800, 600)
    -- fg.screen_scale = 1.2
    fg.world:createEntity('Player', fg.screen_width/4, fg.screen_height/6, {w = 16, h = 28})
    
    fg.world:createEntity('Slime', fg.screen_width/2, fg.screen_height/3, {w = 16, h = 28})
    fg.world:createEntity('Slime', fg.screen_width/2, fg.screen_height/4-50, {w = 16, h = 28})
    
    fg.world:addLayer('Background', {parallax_scale = 0.9})
    fg.world:addToLayer('Background', fg.Background(380, 260, love.graphics.newImage('images/materials/textures/text1.png')))
    fg.world:setLayerOrder({'Background', 'Default'})
    
--    tilemap = fg.Tilemap(150, 150, 32, 32, love.graphics.newImage('images/materials/tileset-normal.png'), {
--        {1, 1, 1, 1, 1, 1, 1, 1, 1},
--        {1, 0, 0, 0, 0, 0, 0, 0, 1},
--        {1, 0, 0, 0, 0, 0, 0, 0, 1},
--        {1, 0, 0, 0, 0, 0, 0, 0, 1},
--        {1, 0, 0, 0, 0, 0, 0, 0, 1},
--        {1, 0, 0, 0, 0, 0, 0, 0, 1},
--        {1, 0, 0, 0, 0, 0, 0, 0, 1},
--        {1, 0, 0, 0, 0, 0, 0, 0, 1},
--        {1, 1, 1, 1, 1, 1, 1, 0, 1},
--    })
--    tilemap:setAutoTileRules({6, 14, 12, 2, 10, 8, 7, 15, 13, 3, 11, 9})
--    tilemap:autoTile()
--    fg.world:generateCollisionSolids(tilemap)
--    fg.world:addToLayer('Default', tilemap)
  
end

function Game:update(dt)

end

function Game:draw()

end

return Game
