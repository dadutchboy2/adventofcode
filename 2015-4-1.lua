md5 = require(script.md5)
--https://gist.githubusercontent.com/evilpacket/3647908/raw/52e65f8793d21bd65fca15da6c267b1ccc4894b6/gistfile1.lua with a few
--change pcall(require, 'bit32') to true, bit32 at line 42 for speed increase

key = "yzbqklnj"

i = 0 repeat
	prehash = key .. i
	posthash = md5.sumhexa(prehash)
	print(posthash)
	if posthash:sub(1, 5) == "00000" then break end
	i += 1
	if i % 100 == 0 then print("still not... " .. i .. " tested") task.wait() end
until nil

print(i)
