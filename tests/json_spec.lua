describe("pokeapi.json", function()
    it("can be required", function()
        require("pokeapi.json")
    end)

    it("can parse json into table", function()
        local result = require("pokeapi.json").parse(
            '{"foo": 23}'
        )
        assert.are.same({
            foo=23
        }, result)
    end)
end)
