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

DownloadFile("Framework/Update.lua", "https://github.com/Alexflamer11/ComputerCraft/new/master/Framework/Update.lua")
