local trail = {}

function trail:new(x,y,pSpeed,pDir)
	math.randomseed(os.time())
	local o = {
		["x"] = x,
		["y"] = y,
		["r"] = math.random(1.5,3),
		["d"] = math.pi-pDir,
		["vD"] = math.random(math.pi*5/6-pDir,math.pi*7/6-pDir),
		["v"] = math.random(pSpeed/5,pSpeed/3),
		["time"] = math.random(3,4),
		["sV"] = math.random(-4,4)
	}

	setmetatable(o,self)
	self.__index = self
	return o
end



function trail:update(dt,friction)
	self.x = self.x+math.cos(self.vD)*dt
	self.y = self.y+math.sin(self.vD)*dt

	self.vD = self.vD*(1-friction*dt)
	self.d = self.d+self.sV*dt

	self.time = self.time - dt
end
function trail:draw(x,y)
	local square = {
		w/2+(x-self.x)+self.r*math.sin(self.d)-self.r*math.cos(self.d), h/2+(y-self.y)-self.r*math.sin(self.d)-self.r*math.cos(self.d),
		w/2+(x-self.x)+self.r*math.sin(self.d)+self.r*math.cos(self.d), h/2+(y-self.y)-self.r*math.sin(self.d)+self.r*math.cos(self.d),
		w/2+(x-self.x)-self.r*math.sin(self.d)-self.r*math.cos(self.d), h/2+(y-self.y)+self.r*math.sin(self.d)-self.r*math.cos(self.d),
		w/2+(x-self.x)-self.r*math.sin(self.d)+self.r*math.cos(self.d), h/2+(y-self.y)+self.r*math.sin(self.d)+self.r*math.cos(self.d),
	}
	love.graphics.setColor(255,255,255)
	love.graphics.polygon(square)
end

return trail
