-- Classes
push = require 'push'
Class = require 'class'
require 'Ball'
require 'paddle'
--Resolution
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
--New Resolution
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243
--Speed of Player
PADDLE_SPEED = 200
--Load function, these are initialized when the game start
function love.load()
	--Changes to the filter (Fixing the blurriness)
	love.graphics.setDefaultFilter('nearest', 'nearest')
	--Title to the window
	love.window.setTitle('pong!')
	--The time of the operating system
	math.randomseed(os.time())
	--Font variables for different sizes
	smallFont = love.graphics.newFont ('font.ttf', 8)
	scoreFont = love.graphics.newFont ('font.ttf', 40)
	bigFont = love.graphics.newFont ('font.ttf', 32)
	--Sound variable
	sounds = {}
	sounds.hit = love.audio.newSource("sounds/paddle_hit.mp3", "static")
	sounds.score = love.audio.newSource("sounds/score.mp3", "static")
	sounds.wall = love.audio.newSource("sounds/wall_hit.mp3", "static") 
	--Setting up the size for the window
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = true,
		vsync = true
	})
	--Different variables to set up paddle and balls
	p1 = paddle(10, 30, 5, 20)
	p2 = paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)
	b = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)
	--score
	s1 = 0
	s2 = 0
	--serving player
	sp = 1
	--starting state
	state = 'start'
end
--function for resizability
function love.resize(w, h)
	push:resize(w, h)
end
--Update function, uses for updating the game constantly
function love.update(dt)
	--Movement and ai initializer
	if p1.ai then
		p1:auto()
	else
		if love.keyboard.isDown('w') then
		p1.dy = -PADDLE_SPEED
		elseif love.keyboard.isDown('s') then
		p1.dy = PADDLE_SPEED
		else
		p1.dy = 0
		end
	end
	if p2.ai then
		p2:auto()
	else
		if love.keyboard.isDown('up') then
			p2.dy = -PADDLE_SPEED
		elseif love.keyboard.isDown('down') then
			p2.dy = PADDLE_SPEED
		else
			p2.dy = 0
		end
	end
	--Setting up changes with the ball after entering serve state
	if state == 'serve' then
		b.dy = math.random(-50, 50)
		if sp == 1 then
			b.dx = math.random(140, 200)
		else
			b.dx = -math.random(140, 200)
		end
	--Ball setting during play state
	elseif state == 'play' then
		--Collision with the paddle w/ speeding up after each hit
		if b:collides(p1) then
			b.dx = -b.dx * 1.03
			b.x = p1.x + 5
			if b.dy < 0 then
				b.dy = -math.random(10, 150)
			else
				b.dy = math.random(10, 150)
			end
			sounds.hit:play()
		end
		if b:collides(p2) then
			b.dx = -b.dx * 1.03
			b.x = p2.x - 4
			if b.dy < 0 then
				b.dy = -math.random(10, 150)
			else
				b.dy = math.random(10, 150)
			end
			sounds.hit:play()
		end
		--Score updating and ending in the victory scene
		if b.x < 0 then
		sp = 1
		s2 = s2 + 1
		sounds.score:play()
		if s2 == 10 then
			win = 2
			state = 'done'
		else
			state = 'serve'
			b:reset()
		end
	end
	if b.x > VIRTUAL_WIDTH then
		sp = 2
		s1 = s1 + 1
		sounds.score:play()
		if s1 == 10 then
			win = 1
			state = 'done'
		else
			state = 'serve'
			b:reset()
		end
	end
	end
	--Preventing the ball to go off screen in the y axis
	if b.y <= 0 then
		b.y = 0
		b.dy = -b.dy
		sounds.wall:play()
	end
	if b.y >= VIRTUAL_HEIGHT - 4 then
		b.y = VIRTUAL_HEIGHT - 4
		b.dy = -b.dy
		sounds.wall:play()
	end
	if state == 'play' then
		b:update(dt)
	end
	p1:update(dt)
	p2:update(dt)
end
--Function for keypressed  (excluding movement since those are constantly being tracked therefore belongs to update function)
function love.keypressed(key)
	--Quitting key
	if key == 'escape' then
		love.event.quit()
	--Using enter to change state of the game
	elseif key == 'enter' or key == 'return' then
		if state == 'start' then
			state =  'serve'
		elseif state == 'serve' then
			state = 'play'
		elseif state == 'done' then
			--Resetting the game after entering done state
			state = 'serve'
			b:reset()
			s1 = 0
			s2 = 0
			if win == 1 then
				sp = 2
			else
				sp = 1
			end
		end
	--Keys to make each sides turns into ai player
	elseif key == 'lctrl' then
		if p1.ai then
			p1.ai = false
		else
			p1.ai = true
		end
	elseif key == 'rctrl' then
		if p2.ai then
			p2.ai = false
		else
			p2.ai = true 
		end
	end
end
--Function for displaying fps in the game
function displayFPS()
	love.graphics.setFont(smallFont)
	love.graphics.setColor(0, 1, 0, 1)
	love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end
--Function for displaying the score
function displayScore()
	love.graphics.setFont(scoreFont)
	love.graphics.print(tostring(s1), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
	love.graphics.print(tostring(s2), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)
end
--Function for outputting our code as a visual
function love.draw()
	--Start of the game with push class' syntax
	push:apply('start')
	--changing the background color
	love.graphics.clear(40/255, 45/255, 52/255, 1)
	--Applying score displaying function
	displayScore()
	--Changing the text when states are changed
	if state == 'start' then
		love.graphics.setFont(smallFont)
		love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')
	elseif state == 'serve' then
		love.graphics.setFont(scoreFont)
		love.graphics.printf('Serve!', 0, 5, VIRTUAL_WIDTH, 'center')
		love.graphics.setFont(smallFont)
		love.graphics.printf('Press left control to turn P1 into bot', 0, 50, VIRTUAL_WIDTH, 'center')
		love.graphics.printf('Press right control to turn P2 into bot', 0, 60, VIRTUAL_WIDTH, 'center')
	elseif state == 'done' then
		love.graphics.setFont(bigFont)
		love.graphics.printf('Player' .. tostring(win) .. ' is the winner!', 0, 20, VIRTUAL_WIDTH, 'center')
	end
	--Stating which is bot which is player
	if p1.ai and p2.ai then
		love.graphics.setFont(smallFont)
		love.graphics.printf('AI', 0, VIRTUAL_HEIGHT - 50, 50, 'right')
		love.graphics.printf('AI', 0, VIRTUAL_HEIGHT - 50, VIRTUAL_WIDTH - 40, 'right')
	elseif p2.ai then
		love.graphics.setFont(smallFont)
		love.graphics.printf('AI', 0, VIRTUAL_HEIGHT - 50, VIRTUAL_WIDTH - 40, 'right')
	elseif p1.ai then
		love.graphics.setFont(smallFont)
		love.graphics.printf('AI', 0, VIRTUAL_HEIGHT - 50, 50, 'right')
	end
	--Calling the ball and the paddle
	p1:render()
	p2:render()
	b:render()
	--Applying FPS displaying function
	displayFPS()
	--Ending of the code the code that is being used to run the game
	push:apply('end')
end