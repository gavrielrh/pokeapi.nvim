describe("pokeapi", function()
    it("can be required", function()
        require("pokeapi")
    end)

    it("can build a query string", function()
        local build_query_string = require("pokeapi")
            ._internal
            .build_query_string

        local empty = build_query_string()
        assert.are.same("", empty)

        local one_param = build_query_string({
            { name="foo", value="bar" }
        })
        assert.are.same("?foo=bar", one_param)

        local two_param = build_query_string({
            { name="a", value="much" },
            { name="b", value="wow" },
        })
        assert.are.same("?a=much&b=wow", two_param)
    end)

    it("can get a resource by id", function()
        local result = require("pokeapi").get_resource("pokemon", 1)
        assert.are.same("bulbasaur", result['forms'][1]['name'])
    end)

    it("can get resources by resource name", function()
        local result = require("pokeapi").get_resources("berry", 2, 1)
        assert.are.same("cheri", result['results'][1]['name'])
    end)

    it("handles missing resource", function()
        local missing_resource = require("pokeapi").get_resource("foo", 1)
        assert.are.same(nil, result)

        local missing_id = require("pokeapi").get_resource("pokemon", 999999)
        assert.are.same(nil, result)
    end)

    it("handles missing resources", function()
        local result = require("pokeapi").get_resources("foo")
        assert.are.same(nil, result)
    end)
end)
