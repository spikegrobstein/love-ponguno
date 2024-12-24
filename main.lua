WinW = 0
WinH = 0

SPEED = 100

local Ball = require("ball")
local Paddle = require("paddle")
local dev = require("dev")

Game = {}

-- Load some default values for our rectangle.
function love.load()
    Game.win_width, Game.win_height = love.window.getMode()
    Game.ball = Ball:new()
    Game.player1 = Paddle:new()
    Game.score = 0
    Game.high_score = 0
    Game.mode = "title"
end

-- Increase the size of the rectangle every frame.
function love.update(dt)
    if Game.mode == "play" then
        Game.ball:update(dt)
        Game.player1:update(dt)

        Game.ball:check_collision(Game.player1)
    elseif Game.mode == "title" then
        if love.keyboard.isDown("space") then
            Game.mode = "play"
        end
    end
end

-- Draw a coloured rectangle.
function love.draw()
    if Game.mode == "play" then
        draw_playfield()

        Game.ball:draw()
        Game.player1:draw()
        --love.graphics.rectangle("fill", ball2.x, ball2.y, ball2.size, ball2.size)
        --dev.draw_debug()
    elseif Game.mode == "title" then
        draw_press_space()
    end
end

function draw_playfield()
    love.graphics.setColor(0.25, 0.25, 0.25)
    love.graphics.setLineWidth(4)
    love.graphics.line(Game.win_width / 2 - 2, Game.win_height * .1, Game.win_width / 2 - 2, Game.win_height)
    love.graphics.print("Score: " .. Game.score .. "  |  High: " .. Game.high_score)
end

function draw_press_space()
    love.graphics.setColor(1,1,1)
    love.graphics.setLineWidth(4)
    love.graphics.rectangle("line", Game.win_width / 2 - 100, Game.win_height / 2 - 50, 200, 100)
    love.graphics.print("Press space to continue", Game.win_width / 2 - 80, Game.win_height / 2 - 30)
end
