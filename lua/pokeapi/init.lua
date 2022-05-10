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
            local status, value = pcall(vim.fn.json_decode, handle:read("*a"))
            handle:close()
            if status then
                api_cache[url] = value
                return value
            end
        end
    end
end

local build_query_string = function(params)
    params = params or {}
    local qs = "?"
    for _, qp in ipairs(params) do
        qs = qs .. qp['name'] .. "=" .. qp['value'] .. "&"
    end
    return string.sub(qs, 0, -2)
end
M._internal.build_query_string = build_query_string

M.get_resource = function(resource, id)
    return curl(host .. resource .. "/" .. id)
end

M.get_resources = function(resource, limit, offset)
    -- Using ordered params so that caching doesn't clash
    local params = {
        { name='limit', value=limit or 20 },
        { name='offset', value=offset or 0 }
    }
    local qs = build_query_string(params)
    return curl(host .. resource .. qs)
end

return M
