local map = {}

function map:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	return o
end
function map:draw()
	
end

return map