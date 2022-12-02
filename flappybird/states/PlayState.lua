--[[
    PlayState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The PlayState class is the bulk of the game, where the player actually controls the bird and
    avoids pipes. When the player collides with a pipe, we should go to the GameOver state, where
    we then go back to the main menu.
]]

PlayState = Class{__includes = BaseState}

PIPE_SPEED = 60
PIPE_WIDTH = 70
PIPE_HEIGHT = 288

BIRD_WIDTH = 38
BIRD_HEIGHT = 24
-- The maximum and minimum time interval for
-- new pipe to be generated
local MIN_INT = 2
local MAX_INT = 4

function PlayState:init()
    self.bird = Bird()
    self.pipePairs = {}
    self.timer = 0
    self.score = 0
    --our initial interval for the first pipe
    self.interval = 3
    -- Boolean pause value
    self.pause = false
    -- initialize our last recorded Y value for a gap placement to base other gaps off of
    self.lastY = -PIPE_HEIGHT + math.random(80) + 20
end

function PlayState:update(dt)
    -- Using letter p to turn pause mode on and off
    if love.keyboard.wasPressed('p') then
        --Turning pause on and off
        if self.pause == false then
            self.pause = true
            Pause()
        else
            self.pause = false
            Unpause()
        end
    end
    --The game will be updated when we're not pausing
    if self.pause == false then
        -- update timer for pipe spawning
        self.timer = self.timer + dt

        -- spawn a new pipe pair every between 2 and 4 seconds
        if self.timer > self.interval then
            -- modify the last Y coordinate we placed so pipe gaps aren't too far apart
            -- no higher than 10 pixels below the top edge of the screen,
            -- and no lower than a gap length (90 pixels) from the bottom
            local y = math.max(-PIPE_HEIGHT + 10, 
                math.min(self.lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
            self.lastY = y

            -- add a new pipe pair at the end of the screen at our new Y
            table.insert(self.pipePairs, PipePair(y))

            -- reset timer
            self.timer = 0
            -- Randomizing our time interval every time
            -- a new pipe spawn
            self.interval = math.random(MIN_INT, MAX_INT)
        end

        -- for every pair of pipes..
        for k, pair in pairs(self.pipePairs) do
            -- score a point if the pipe has gone past the bird to the left all the way
            -- be sure to ignore it if it's already been scored
            if not pair.scored then
                if pair.x + PIPE_WIDTH < self.bird.x then
                    self.score = self.score + 1
                    pair.scored = true
                    sounds['score']:play()
                end
            end

            -- update position of pair
            pair:update(dt)
        end

        -- we need this second loop, rather than deleting in the previous loop, because
        -- modifying the table in-place without explicit keys will result in skipping the
        -- next pipe, since all implicit keys (numerical indices) are automatically shifted
        -- down after a table removal
        for k, pair in pairs(self.pipePairs) do
            if pair.remove then
                table.remove(self.pipePairs, k)
            end
        end

        -- simple collision between bird and all pipes in pairs
        for k, pair in pairs(self.pipePairs) do
            for l, pipe in pairs(pair.pipes) do
                if self.bird:collides(pipe) then
                    sounds['explosion']:play()
                    sounds['hurt']:play()

                    gStateMachine:change('score', {
                        score = self.score
                    })
                end
            end
        end

        -- update bird based on gravity and input
        self.bird:update(dt)

        -- reset if we get to the ground
        if self.bird.y > VIRTUAL_HEIGHT - 15 then
            sounds['explosion']:play()
            sounds['hurt']:play()

            gStateMachine:change('score', {
                score = self.score
            })
        end
    end
end

function PlayState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end

    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)
    --Preventing our bird to move and displaying
    --a paused message while in pause
    if self.pause == false then
        self.bird:render()
    else
        love.graphics.setFont(hugeFont)
        love.graphics.printf('Paused', 0, 64, VIRTUAL_WIDTH, 'center')
    end
end

--[[
    Called when this state is transitioned to from another state.
]]
function PlayState:enter()
    -- if we're coming from death, restart scrolling
    scrolling = true
end

--[[
    Called when this state changes to another state.
]]
function PlayState:exit()
    -- stop scrolling for the death/score screen
    scrolling = false
end
-- our pause function, this is shorter than making
-- a whole new state
function Pause()
    --pausing our bgm while in pause
    sounds['music']:pause()
    --playing the pause sound
    sounds['pause']:play()
    -- turning off our background and ground scroll
    BACKGROUND_SCROLL_SPEED = 0
    GROUND_SCROLL_SPEED = 0
end
-- unpause function, used when we get out of pause
function Unpause()
    --playing the bgm after we get out of pause mode
    sounds['music']:play()
    --play the pause sound once more
    sounds['pause']:play()
    --turning our scroll back on
    BACKGROUND_SCROLL_SPEED = 30
    GROUND_SCROLL_SPEED = 60
end