local text = {}

function text:new()
	local o = {
		["lines"] = {""},
		["line"] = 1,
		["cursor"] = 0,
		["counter"] = 0,
		["cMax"] = .5
	}

	setmetatable(o,self)
	self.__index = self
	return o
end
function text:upText(t)
	if self.cursor == #self.lines[self.line] then
		self.lines[self.line] = self.lines[self.line]..t
	else
		self.lines[self.line] = string.sub(self.lines[self.line],self.cursor-1)..t..string.sub(self.lines[self.line],self.cursor,#self.lines[self.line])
	end
	self.cursor = self.cursor+1
end
function text:upSpec(key)
	print(key)
	if key == "backspace" then
		if self.cursor == #self.lines[self.line] then
			self.lines[self.line] = string.sub(self.lines[self.line],-2)
			self.cursor = self.cursor-1
		end
	end
end
function text:draw()
	love.graphics.line(15,0,15,love.window.getHeight())
	for i=1,#self.lines do
		love.graphics.print(i..": ",0,(i-1)*10)
		love.graphics.print(self.lines[i],16,(i-1)*10)
	end
end

return text