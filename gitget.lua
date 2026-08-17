function parseGitHubContents(jsonString)
    -- Парсим JSON в таблицу Lua
    local data = textutils.unserializeJSON(jsonString)
    if not data then
        print("Ошибка: не удалось распарсить JSON")
        return {}
    end
    
    local result = {}
    local counter = 1
    
    for _, item in ipairs(data) do
        -- Проверяем, что это файл (не папка) и есть download_url
        if item.type == "file" and item.download_url then
            result[counter] = {
                number = counter,
                name = item.name,
                url = item.download_url
            }
            counter = counter + 1
        end
    end
    
    return result
end

local repo = arg[1]
local dir = arg[2] == nil and "" or arg[2]

print("repo: ", repo)
print("directory:", dir)
local link = "https://api.github.com/repos/" .. repo .. "/contents/" .. dir
print("download list from: ", link)
shell.run("wget " .. link .. " gitget_tmp.txt")
local file = fs.open("gitget_tmp.txt", "r")
local content = file.readAll()
shell.run("rm gitget_tmp.txt")
--print(content)
local links = parseGitHubContents(content)
for key, value in pairs(links) do
    shell.run("wget " .. value.url .. " " .. value.name)
end

