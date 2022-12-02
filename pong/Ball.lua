Ball = Class{}
--Init function which is used for determining which variables can be 
--changed in other file the value aka the original value
function Ball:init(x, y, width, height)
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	self.dx = math.random(2) == 1 and math.random(-80, -100) or math.random(80, 100)
	self.dy = math.random(2) == 1 and -100 or 100
end
--Resetting the ball to the center of the screen
function Ball:reset()
	self.x = VIRTUAL_WIDTH / 2 - 2
	self.y = VIRTUAL_HEIGHT / 2 - 2
	self.dy = math.random(2) == 1 and 100 or -100
	self.dx = math.random(-50, 50)
end
--The update function which can be used to change the movement of the ball
function Ball:update(dt)
	self.x = self.x + self.dx * dt 
	self.y = self.y + self.dy * dt
end
--Render function that is used to visualize the size of the ball
function Ball:render()
	love.graphics.rectangle('fill', self.x , self.y, self.width, self.height)
end
--Changing the behavior of the ball so that it bounce off paddle each collision
function Ball:collides(paddle)
	if self.x > paddle.x + paddle.width or paddle.x > self.x + self.width then
		return false
	end
	if self.y > paddle.y + paddle.height or paddle.y > self.y + self.height then
		return false
	end
	return true
end