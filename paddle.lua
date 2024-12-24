local Paddle = {}

function Paddle:new(p)
    p = p or {
        width = 10,
        height = 50,
        position = Game.win_height / 2 - 25,
        x = 20,
        max_speed = 10,
        current_speed = 0,
    }

    setmetatable(p, self)
    self.__index = self
    return p
end

function Paddle:draw()
    love.graphics.setColor(0, 0.5, 0)
    love.graphics.setLineWidth(1)
    love.graphics.rectangle("fill", self.x, self.position - self.height / 2, self.width, self.height)
end

function Paddle:update(dt)
    if love.keyboard.isDown("down") then
        self.current_speed = self.current_speed + 1
    elseif love.keyboard.isDown("up") then
        self.current_speed = self.current_speed - 1
    else
        self.current_speed = 0
    end

    if self.current_speed > self.max_speed then
        self.current_speed = self.max_speed
    end

    if self.current_speed < -self.max_speed then
        self.current_speed = -self.max_speed
    end

    self.position = self.position + self.current_speed
end

return Paddle
