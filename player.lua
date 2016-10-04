local player = {}

function player:new(color)
	color = color or {255,255,255}
	local o = {
		["x"] = 0,
		["y"] = 0,
		["v"] = {["h"] = 0, ["v"] = 0},
		["s"] = 500,
		["d"] = 0,
		["t"] = 10,
		["color"] = {255,255,255}
	}
	setmetatable(o,self)
	self.__index = self
	return o
end
function player:update(dt,tmult, vmult, friction)
	if love.keyboard.isDown("a") then
		self.v.h = self.v.h - self.t*dt*tmult
	end
	if love.keyboard.isDown("s") then
		self.v.v = self.v.v - self.s*dt*vmult
	end
	if love.keyboard.isDown("d") then
		self.v.h = self.v.h + self.t*dt*tmult
	end
	if love.keyboard.isDown("w") then
		self.v.v = self.v.v + self.s*dt*vmult
	end

	self.d = self.d+self.v.h*dt
	if self.d > 2*math.pi then
		self.d = self.d-2*math.pi
	elseif self.d < 0 then
		self.d = self.d+2*math.pi
	end

	self.y = self.y+math.sin(self.d)*self.v.v*dt
	self.x = self.x+math.cos(self.d)*self.v.v*dt

	self.v.h = self.v.h*(1-friction*60*dt)
	self.v.v = self.v.v*(1-friction*60*dt)
	if math.abs(self.v.h) < .051 then self.v.h = 0 end
	if math.abs(self.v.v) < .051 then self.v.v = 0 end
end
function player:draw()
	local triangle = {
		w/2-7*math.sin(self.d), h/2+7*math.cos(self.d),
		w/2+7*math.sin(self.d), h/2-7*math.cos(self.d),
		w/2+15*math.cos(self.d), h/2+15*math.sin(self.d),
	}
	local rectangle = {
		w/2-7*math.sin(self.d), h/2+7*math.cos(self.d),
		w/2+7*math.sin(self.d), h/2-7*math.cos(self.d),
		w/2-11*math.sin(self.d), h/2+3*math.cos(self.d),
		w/2+3*math.sin(self.d), h/2-11*math.cos(self.d)
	}
	love.graphics.setColor(0,0,0)
	love.graphics.polygon("fill",triangle)
	love.graphics.polygon("fill",rectangle)

	love.graphics.setColor(self.color)
	love.graphics.polygon("line", triangle)
	love.graphics.polygon("line", rectangle)
end
return player
