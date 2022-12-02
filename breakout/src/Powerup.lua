--Assignment
Powerup = Class{}

function Powerup:init(ptype, x, y)
    --size of the powerups sprite
    self.width = 16
    self.height = 16

    --The velocity of the powerups
    self.dy = 50
    self.dx = 0
    self.x = x
    self.y = y

    --type of powerups we'll index since there's key and 
    --more balls powerups
    self.ptype = ptype
    self.inplay = true
end

function Powerup:collides(target)
    --Same collision system as the balls
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end 

    return true
end

function Powerup:update(dt)
    --basic update function to make them fall from the bricks
    if self.y < VIRTUAL_HEIGHT then
        self.y = self.y + self.dy * dt
    end

end

function Powerup:render()
    --drawing the powerups
    if self.inplay then
        love.graphics.draw(gTextures['main'], gFrames['power'][self.ptype], self.x, self.y)
    end
end