local io = require("IO_settings")
local codes = require("codes")

local OUT = {}

local tick

function sendChar(char) do
	local c = codes.ltc[char];
    	if not c then return end

	for i = 1, #c do
		rs.setOutput(io.OUT_DATA, c:sub(i,i) == "-")
		rs.setOutput("left", tick)
		tick = not tick
        	os.sleep(1 / speed)
	end
end

function OUT.print(input) do
	tick = rs.getOutput(io.OUT_SYNTH)
	rs.setOutput(io.OUT_DATA, false)
	
	for i = 1, #str do
		sendChar(str:sub(i,i))
	end
end

function OUT.println(input) do
	print(inpit .. "&")
end

return OUT