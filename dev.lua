function draw_debug()
    love.graphics.setColor(0.50, 0.25, 0.25)
    love.graphics.setLineWidth(1)
    vr(Game.player1.x + Game.player1.width)
    hr(Game.player1.position - Game.player1.height / 2)
    hr(Game.player1.position + Game.player1.height / 2)

    --love.graphics.setColor(0.25, 0.25, 0.25)
    --love.graphics.print("x: " .. math.floor(Game.ball.x) .. " | width: " .. Game.win_width)
end

function hr(y)
    love.graphics.line(0, y, Game.win_width, y)
end

function vr(x)
    love.graphics.line(x, 0, x, Game.win_height)
end

return {
    draw_debug = draw_debug,
    hr,
    vr,
}
