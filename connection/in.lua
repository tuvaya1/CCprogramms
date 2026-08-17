local io = require("IO_settings")
local codes = require("codes")

local IN = {}

function toString(input)
  local s = ""
  local len = #input
  for i = 1, len, 8 do
    local chunk = input:sub(i, i + 7)
    local code = codes[chunk] or "<?>"
    s = s .. code
  end
  return s
end

function IN.readLine()
	local last = rs.getInput("left")
	local input = ""
	while true do
		local event= os.pullEvent("redstone")
		if rs.getInput(io.IN_SYNTH) ~= last then
			last = rs.getInput(io.IN_SYNTH)
			if (rs.getInput("back")) then
				write("-")
				input = input .. "-"
			else 
				write(".")
				input = input .. "."
			end
		end
		if #input > 0 and #input % 8 == 0 then 
	  		local decoded = toString(input)
	  		if decoded:sub(-1) == "&" then
	   			return (decoded:sub(1, -2))
	  		end
		end

	end
end

return IN
