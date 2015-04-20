local Player = fg.Class('Player', 'Entity')
Player:implement(fg.PhysicsBody)

Player.enter = {'Solid'}

function Player:new(area, x, y, settings)
    Player.super.new(self, area, x, y, settings)
    self:physicsBodyNew(area, x, y, settings)

    self.fixture:setFriction(0)

    -- fg.world.camera:follow(self, {lerp = 1, follow_style = 'lockon'})

    self.direction = 'right'
    self.animation_state = 'idle'

    self.idle = fg.Animation(love.graphics.newImage('images/player/idle.png'), 32, 32, 0)
    self.walk = fg.Animation(love.graphics.newImage('images/player/run.png'), 32, 32, 0.13)
    -- self.walk = fg.Animation(love.graphics.newImage('images/player/druid.png'), 75, 172, 25, 43, 0.30, 12)

    fg.input:bind('q', 'move_left')
    fg.input:bind('d', 'move_right')
    fg.input:bind('z', 'move_up')
    fg.input:bind('s', 'move_down')
    fg.input:bind('mouse1', 'mouse_attack')
    
end

function Player:update(dt)
    self:physicsBodyUpdate(dt)

    if fg.input:down('move_up') then
        self.direction = 'up'
        local vx, vy = self.body:getLinearVelocity()
        self.body:setLinearVelocity(vx, -150)
    end
    if fg.input:down('move_left') then
        self.direction = 'left'
        local vx, vy = self.body:getLinearVelocity()
        self.body:setLinearVelocity(-150, vy)
    end
    if fg.input:down('move_right') then
        self.direction = 'right'
        local vx, vy = self.body:getLinearVelocity()
        self.body:setLinearVelocity(150, vy)
    end
    if fg.input:down('move_down') then
        self.direction = 'down'
        local vx, vy = self.body:getLinearVelocity()
        self.body:setLinearVelocity(vx, 150)
    end
    if not fg.input:down('move_left') and not fg.input:down('move_right') and not fg.input:down('move_up') and not fg.input:down('move_down') then
        local vx, vy = self.body:getLinearVelocity()
        -- self.body:setLinearVelocity(48*dt*vx, vy)
        self.body:setLinearVelocity(0, 0)
    end

    local vx, vy = self.body:getLinearVelocity()
    if math.abs(vx) < 25 and math.abs(vy) < 5 then self.animation_state = 'idle'
    else self.animation_state = 'walk' end
--    if self.jumping then self.animation_state = 'jump' end
--    if vy > 5 then self.animation_state = 'fall' end
    self[self.animation_state]:update(dt)
    -- self[self.animation_state]:update(dt)
end

function Player:draw()
    self:physicsBodyDraw()
    if self.direction == 'right' then
        self[self.animation_state]:draw(self.x, self.y, 0, 1, 1, 
                                        self[self.animation_state].frame_width/2, 
                                        self[self.animation_state].frame_height/2 + 2)
    elseif self.direction == 'left' then
        self[self.animation_state]:draw(self.x, self.y, 0, -1, 1, 
                                        self[self.animation_state].frame_width/2, 
                                        self[self.animation_state].frame_height/2 + 2)
    elseif self.direction == 'up' then
        self[self.animation_state]:draw(self.x, self.y, 0, 1, 1, 
                                        self[self.animation_state].frame_width/2, 
                                        self[self.animation_state].frame_height/2 + 2)
    elseif self.direction == 'down' then
        self[self.animation_state]:draw(self.x, self.y, 0, 1, 1, 
                                        self[self.animation_state].frame_width/2, 
                                        self[self.animation_state].frame_height/2 + 2)
    end
end

function Player:onCollisionEnter(other, contact)
    if other.tag == 'Solid' then
        local x1, y1, x2, y2 = contact:getPositions()
        local player_bottom = self.y + self.h/2 - 4
        if y1 > player_bottom then
--            self.jumping = false
--            self.jumps_left = self.max_jumps
              
        end
    end
end

return Player

