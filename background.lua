local background  = {}

function background:new(w, h)
	local o = {
		["starDensity"] = 2.5,
		["xSections"] = 7,
		["ySections"] = 7*h/w,
		["screenW"] = w,
		["screenH"] = h,
		["xPrev"] = 0,
		["yPrev"] = 0,
		["color"] = {255,255,255},
		["xCounter"] = 0,
		["yCounter"] = 0,
		["xScale"] = 0,
		["yScale"] = 0
	}
	o["w"] = w+2*w/o.xSections
	o["h"] = h+2*h/o.ySections
	
	setmetatable(o,self)
	self.__index = self
	return o

end
function background:init()
	math.randomseed(os.time())
	for i=1, self.xSections do
		self[i] = {}
		for a=1, self.ySections do
			self[i][a] = {}
			for b=1, self.starDensity do
				self[i][a][b] = {
					["x"] = math.random(self.w/self.xSections/self.starDensity*(b-1),self.w/self.xSections/self.starDensity*b),
					["y"] = math.random(self.h/self.ySections/self.starDensity*(b-1),self.h/self.ySections/self.starDensity*b)
				}
			end
		end
	end
end
function background:update(x,y)
	local dx = x-self.xPrev
	local dy = y-self.yPrev

	self.xCounter = self.xCounter+dx
	self.yCounter = self.yCounter+dy


	if self.xCounter > self.screenW/self.xSections then
		local temp = self[1]
		for i=2, #self do
			self[i-1] = self[i]
		end
		self[#self] = temp
		self.xCounter = self.xCounter-self.w/self.xSections
		self.xScale = self.xScale+1
	elseif self.xCounter < -self.screenW/self.xSections then
		local temp = self[#self]
		for i=1, #self-1 do
			self[#self-i+1] = self[#self-i]
		end
		self[1] = temp
		self.xCounter = self.xCounter+self.w/self.xSections
		self.xScale = self.xScale-1
	end

	if self.yCounter > self.screenH/self.ySections then
		for i=1, #self do
			table.insert(self[i],table.remove(self[i],1))
		end
		self.yCounter = self.yCounter-self.h/self.ySections
		self.yScale = self.yScale+1
	elseif self.yCounter < -self.screenH/self.ySections then
		for i=1, #self do
			table.insert(self[i],1,table.remove(self[i]))
		end
		self.yCounter = self.yCounter+self.h/self.ySections
		self.yScale = self.yScale-1
	end

	self.xPrev = x
	self.yPrev = y

	for i=1, #self do
		for a=1, #self[i] do
			for b=1, #self[i][a] do
				self[i][a][b].x = self[i][a][b].x-dx
				self[i][a][b].y = self[i][a][b].y-dy
			end
		end
	end
end
function background:draw(c)
	c = c or {255,255,255}
	love.graphics.setColor(self.color)
	for i=1, #self do
		for a=1, #self[i] do
			for b=1, #self[i][a] do
				love.graphics.circle("fill",self.xScale*self.w/self.xSections+self[i][a][b].x+((self.w/self.xSections)*(i-1))-self.screenW/self.xSections,self.yScale*self.h/self.ySections+self[i][a][b].y+((self.h/self.ySections)*(a-1))-self.screenH/self.ySections,1,10)
			end
		end
	end
	love.graphics.setColor(c)
end
return background
