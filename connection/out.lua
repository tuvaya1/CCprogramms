local io = require("IO_settings")
local codes = require("codes")

local OUT = {}

local tick
local speed = 40

function sendChar(char)
	local c = codes.ltc[char];
    	if not c then return end
    
	for i = 1, #c do
		rs.setOutput(io.OUT_DATA, c:sub(i,i) == "-")
    os.sleep(1/speed);
        rs.setOutput(io.OUT_SYNTH, not tick)
		tick = not tick
        	os.sleep(1 / speed)
	end
end

function OUT.print(input)
	tick = rs.getOutput(io.OUT_SYNTH)
	rs.setOutput(io.OUT_DATA, false)
	
	for i = 1, #input do
		sendChar(input:sub(i,i))
	end
end

function OUT.println(input)
	OUT.print(input .. "&")
end

return OUT
