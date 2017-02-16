function love.load()
	friction = .05 --.05 default
	tmult = 1
	vmult = 1
	
	require "save"
	back = require "background"
	play = require "player"
	editor = require "text"

	w, h = love.graphics.getDimensions()

	player = play:new()

	text = editor:new()

	background = back:new(w,h)
	background:init()

	framerate = 0


	state = "ship"


end
function love.textinput(t)
	if state == "type" then
		text:upText(t)
	end
end
function love.keyreleased(key)
	if state == "text" then
		text:upSpec(key)
	end
	if key == "m" then
		state = "map"
	elseif key == "`" then
		state = "type"
	elseif key == "escape" then
		if state ~="ship" then
			state = "ship"
		else
			love.event.quit()
		end
	end
end
function love.update(dt)
	framerate = 1/dt

	if state == "ship" then
		player:update(dt, tmult, vmult, friction)
		background:update(player.x,player.y)
	end

end
function love.draw()
	if state == "ship" then
		background:draw()	
		player:draw()
	elseif state == "type" then
		text:draw()
	end
end
