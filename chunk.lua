local chunk = {}

function chunk:new(x,y,beacons,ships)
	beacons = beacons or {}
	ships = ships or {}
	local o = {
		["xOff"] = x,
		["yOff"] = y,
		["size"] = 1000,
		["beacons"] = beacons,
		["ships"] = ships --non-constant table, used when loading/ unloading chunks
	}

	setmetatable(o, self)

	self.__index = self
	return o
end
function chunk:init() --random needs to be seeded before use
	self["id"] = self.xOff.." "..self.yOff
end
function chunk:update(dt, friction)
	for i=1, #self.beacons do
		--self.beacons[i]:update(dt)
	end
	for i=1, #self.ships do
		--self.ships[i]:update(dt,friction)
	end
end

return chunk