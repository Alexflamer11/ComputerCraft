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
  else
    return false
  end
    
  return true
end

-- Download the update file along with everything else
DownloadFile("Framework/Update.lua", "https://raw.githubusercontent.com/Alexflamer11/ComputerCraft/master/Framework/Update.lua")
