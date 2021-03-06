local CurrentLine = 1
function Output(text)
	term.setCursorPos(1, CurrentLine)
	CurrentLine = CurrentLine + 1
	term.write(text)
end

term.clear()
term.setCursorPos(1, 1)
term.setTextColor(colors.white)
term.setBackgroundColor(colors.black)
Output("Starting update...")

-- Make sure our directory exists
if not fs.isDir("Framework") then
	fs.makeDir("Framework")
end

-- Download a new file, returns true if success
function DownloadFile(path, link)
	local Result = http.get(link)
	if Result then
		local File = fs.open(path, "w")
		File.write(Result.readAll())
		File.close()
		
		Output("Downloaded \""..path.."\" successfully.")
	else
		Output("Unable to download \""..path.." from ("..link..")")
		return false
	end
	
	return true
end

-- Download the update file along with everything else
DownloadFile("Framework/Update.lua", "https://raw.githubusercontent.com/Alexflamer11/ComputerCraft/master/Framework/Update.lua")
DownloadFile("Framework/Main.lua", "https://raw.githubusercontent.com/Alexflamer11/ComputerCraft/master/Framework/Main.lua")

Output("Update finished")
for i=3, 1, -1 do
	Output("Closing in "..tostring(i))
	sleep(1)
end

term.clear()
term.setCursorPos(1, 1)
