local M = {}

local json = require("pokeapi.json")

M._internal = {}

local host = "https://pokeapi.co/api/v2/"

local api_cache = {}

local curl = function(url)
    if api_cache[url] then
        return api_cache[url]
    else
        local handle = io.popen("curl -s " .. url)
        if handle then
            local result = json.parse(handle:read("*a"))
            handle:close()
            api_cache[url] = result
            return result
        end
    end
end

local build_query_string = function(params)
    params = params or {}
    local qs = "?"
    for param, value in pairs(params) do
        qs = qs .. param .. "=" .. value .. "&"
    end
    return string.sub(qs, 0, -2)
end
M._internal.build_query_string = build_query_string

--[[
print(_build_query_string({
    limit=20,
    offset=20
}))
print(_build_query_string({
    limit=20
}))
--]]

M.get_resource = function(resource, id)
    return curl(host .. resource .. "/" .. id)
end

M.get_resources = function(resource, limit, offset)
    local params = {}
    if limit then
        params['limit'] = limit
    end
    if offset then
        params['offset'] = offset
    end
    local qs = build_query_string(params)
    return curl(host .. resource .. qs)
end

return M
