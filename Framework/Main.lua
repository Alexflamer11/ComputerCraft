local Api = {}

-- Simple rounding function (I feel lua should have this but whatever)
function math.Round(num, pos)
	local Mult = 10 ^ (pos or 0)
	return math.floor(num * Mult + 0.5) / Mult
end

Api.MonitorManager = {}
function Api.MonitorManager.new(monitor)
	assert(monitor ~= nil, "Monitor must not be nil")

	-- Set the monitor data
	local MonitorApi = {}
	MonitorApi.Monitor = monitor
	MonitorApi.CursorPosX = 1
	MonitorApi.CursorPosY = 1
	
	-- Start on a new line
	function MonitorApi:NewLine()
		self.Monitor.CursorPosX = self.CursorPosX + 1
		self.Monitor.setCursorPos(1, self.CursorPosX)
	end	
	
	-- Appends text to the monitor
	function MonitorApi:Write(...)
		self.Monitor.write(...)
	end
	
	-- Writes a new line to the monitor
	function MonitorApi:WriteLine(...)
		self:NewLine()
		self.Monitor.write(...)
	end
	
	function MonitorApi:WriteCenterX(...)
		local Data = {...}
		
		-- Make sure everythign is a fomatted string
		for Index,Value in pairs(Data) do
			if type(Value) ~= "string" then
				Data[Index] = tostring(Value)
			end
		end
		
		-- Always have a space between multiple results
		local Result = Data:concat(" ")
		
		-- Format the result
		local X,Y = self.Monitor.getSize()
		local OldX, OldY = self.Monitor.getCursorPos()
		self.Monitor.setCursorPos(math.round((X / 2) - (Result:len() / 2)), OldY)
		self.Monitor.write(text)
	end
	
	-- Centers the arguments passed (a space will be added to all results)
	function MonitorApi:WriteLineCenterX(...)
		local Data = {...}
		
		-- Make sure everythign is a fomatted string
		for Index,Value in pairs(Data) do
			if type(Value) ~= "string" then
				Data[Index] = tostring(Value)
			end
		end
		
		-- Always have a space between multiple results
		local Result = Data:concat(" ")
		
		-- Format the result
		self:NewLine()
		local X,Y = self.Monitor.getSize()
		local OldX, OldY = self.Monitor.getCursorPos()
		self.Monitor.setCursorPos(math.round((X / 2) - (Result:len() / 2)), OldY)
		self.Monitor.write(text)
	end
	
	-- Clears a monitors screen
	function MonitorApi:Clear()
		self.Monitor.clear()
		self.Monitor.setCursorPos(1, 1)
		self.CursorPosX = 1
		self.CursorPosY = 1
	end
	
	-- Resets a monitor to defaults
	function MonitorApi:Reset()
		-- Restore defaults
		self.Monitor.setTextColor(colors.white)
		self.Monitor.setBackgroundColor(colors.black)
		self.Monitor.setTextScale(1)
		
		-- Clear the monitor too
		self:Clear()
	end
	
	-- Changes the monitor colors
	function MonitorApi:SetTextColor(color)
		self.Monitor.setTextColor(color)
	end
	
	-- Sets a monitor background color
	function MonitorApi:SetBackgroundColor(color)
		self.Monitor.setBackgroundColor(color)
	end
	
	return MonitorApi
end

return Api
