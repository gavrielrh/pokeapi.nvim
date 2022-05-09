local M = {}

local _host = "https://pokeapi.co/api/v2/"

local _api_cache = {}

local _curl = function(url)
    if _api_cache[url] then
        return _api_cache[url]
    else
        local handle = io.popen("curl " .. url)
        if handle then
            local result = handle:read("*a")
            handle:close()
            _api_cache[url] = result
            return result
        end
    end
end

local _build_query_string = function(params)
    params = params or {}
    local qs = "?"
    for param, value in pairs(params) do
        qs = qs .. param .. "=" .. value .. "&"
    end
    return string.sub(qs, 0, -2)
end

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
    return _curl(_host .. resource .. "/" .. id)
end

M.get_resources = function(resource, limit, offset)
    local params = {}
    if limit then
        params.limit = limit
    end
    if offset then
        params.offset = offset
    end
    local qs = _build_query_string(params)
    return _curl(_host .. resource .. qs)
end

print(M.get_resources("ability", 3))

return M
