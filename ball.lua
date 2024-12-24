-- a ball
local Ball = {}

function Ball:new(b)
    b = b or {
        x = 100,
        y = 100,
        speed = SPEED,
        dx = -1,
        dy = 1,
        size = 5,
    }
    setmetatable(b, self)
    self.__index = self
    return b
end

function Ball:update(dt)
    self.x = self.x + self.dx * self.speed * dt
    self.y = self.y + self.dy * self.speed * dt

    -- bounce off top and bottom
    if self.y < 5 or self.y > Game.win_height - self.size then
        self.dy = self.dy * -1
    end
end

function Ball:reset()
    self.x = math.random(5, Game.win_width / 2)
    self.y = math.random(Game.win_height)
    self.speed = SPEED
    if math.random() > 0.5 then
        self.dx = self.dx * -1
    end

    if math.random() > 0.5 then
        self.dy = self.dy * -1
    end
end

-- check if ball hits the paddle
-- if so, bounce it back
-- otherwise, keep going
function Ball:check_collision(paddle)
    -- far wall
    if self.x > Game.win_width / 2 - 5 then
        self.dx = self.dx * -1
        return
    end

    -- is ball even close to the paddle on the X
    -- if not, then we just bail
    if self.x > paddle.x + paddle.width then
        return
    end

    -- check if ball is touching paddle
    -- if so, then bounce!
    -- ball moving left
    if self.dx < 0 then
        -- ball within paddle
        if self.y >= paddle.position - paddle.height / 2 and self.y <= paddle.position + paddle.height / 2 then
            if self.x <= paddle.x + paddle.width then
                -- smack
                self.x = paddle.x + paddle.width
                self.dx = self.dx * -1
                self.speed = self.speed + 25
                Game.score = Game.score + 1
                return
            end
        end
    end

    -- is the ball past the paddle?
    -- if so, then score and reset
    if self.x < paddle.x - paddle.width / 2 then
        -- TODO: implement score

        if Game.score > Game.high_score then
            Game.high_score = Game.score
        end

        Game.score = 0
        self:reset()

        Game.mode = "title"

        return
    end

end

function Ball:draw()
    love.graphics.setColor(0, 0.4, 0.4)
    love.graphics.setLineWidth(1)
    love.graphics.circle("fill", self.x, self.y, self.size)
end

return Ball
