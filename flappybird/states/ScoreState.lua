--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
    --Our new values, one to detect if there's award
    --one to determine the reward. We also use
    --a new Award function to receive the changes in awards
    self.isAward, self.award = Award(self.score)
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')
    --New part for displaying the badge when the player
    --get one
    if self.isAward == true then
        love.graphics.printf('You earned ' .. tostring(self.award), 0, 120, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(awards[self.award], VIRTUAL_WIDTH / 2, 140)
    end
    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end
--Award function to detect and determine our award
function Award(score)
    --Each if represent the score threshold where
    --if achieved, the player will receive a certain
    --badge. No reward provided if the score is too low
    if score >= 30 then
        return true, 'gold'
    elseif score >= 20 then
        return true, 'silver'
    elseif score >= 5 then
        return true, 'bronze'
    else
        return false, ''
    end
end