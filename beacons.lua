local beacon = {}

function beacon:new(x,y,type)
	if not type then
		local types = {"legal","illegal","pirate","mine"}
		type = types[math.random(4)]
	end
	local o = {
		["type"] = type,
		["x"] = x,
		["y"] = y
	}

	setmetatable(o, self)
	self.__index = self
	return o
end
function beacon:init()
	if self.type == "mine" then
		self.production = math.random(100,1000)
		self.resource = 0
	elseif self.type == "legal" then
		self.resource = math.random(10,20)
	elseif self.type == "illegal" then
		self.resource = math.random()
	elseif self.type == "pirate" then

	end
	self.credits = math.random(500,800)
end
function beacon:update()


return beacon