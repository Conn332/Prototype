local universe = {}

function universe:new()
	local o = {
		["loadRadius"] = 50,
		["chunkSize"] = 1000
	}

	setmetatable(o, self)
	self.__index = self
	return o
end
function universe:init()
	
end

return universe