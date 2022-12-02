paddle = Class{}
--Init function which is used for determining which variables can be 
--changed in other file the value aka the original value
function paddle:init(x, y, width, height)
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	self.dy = 0
	self.ai = false
end
--Updating function which is being used to prevent the paddle from going off screen
function paddle:update(dt)
	if self.dy < 0 then
		self.y = math.max(0, self.y + self.dy * dt)
	else
		self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)
	end
end
--function for ai movement 
function paddle:auto()
	if state == 'play' then
		--The middle of our paddle in terms of width
		predicted_bx = self.x + (self.width / 2)
		--The direction and steepness of the ball movement
		slope = b.dy/b.dx
		--The predicted location of the ball in terms of y
		predicted_by = slope * (predicted_bx - b.x) + b.y
		--Amount of part our paddle is divided into
		pp = 6
		--A top part of our paddle
		top = self.y + (self.height / pp)
		--A bottom part of our paddle
		bottom = self.y + ((pp - 1) * self.height / pp)
		--The movement of the ai according to the predicted all location
		if predicted_by < top then
			self.dy = -PADDLE_SPEED
		elseif predicted_by > bottom then
			self.dy = PADDLE_SPEED
		else
			self.dy = 0
		end
	end
end

--Render function, being used to determine the size of the paddle
function paddle:render()
	love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end