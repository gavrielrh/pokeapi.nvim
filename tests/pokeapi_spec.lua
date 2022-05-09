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
            foo="bar"
        })
        assert.are.same("?foo=bar", one_param)

        local two_param = build_query_string({
            a="much",
            b="wow"
        })
        assert.are.same(
            1,
            string.find(
                two_param,
                "^?%a+=%a+&%a+=%a+$"
            )
        )
    end)

    it("can get a resource by id", function()
        local result = require("pokeapi").get_resource("pokemon", 1)
        assert.are.same("bulbasaur", result['forms'][1]['name'])
    end)
end)
