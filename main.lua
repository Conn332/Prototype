function love.load()
	friction = .05 --.05 default
	tmult = 1
	vmult = 1
	
	back = require "background"
	play = require "player"

	w, h = love.graphics.getDimensions()

	player = play:new()

	background = back:new(w,h)
	background:init()

	framerate = 0
end
function love.keyreleased(key)
end
function love.update(dt)
	framerate = 1/dt

	player:update(dt, tmult, vmult, friction)

	background:update(player.x,player.y)

end
function love.draw()

	background:draw()

	player:draw()

	love.graphics.print(player.x,0,0)
	love.graphics.print(player.y,0,10)
	love.graphics.print(player.d,0,20)
	love.graphics.print(player.v.v,0,30)
	love.graphics.print(math.floor(framerate),w-20,0)
end
