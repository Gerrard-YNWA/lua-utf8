local luaunit = require("luaunit")

TestLuaUtf8 = {
    utf8 = require("lua-utf8")
}


function TestLuaUtf8:testUtf8Validate()
    local cases = {
        {
            value = "",
            valid = true
        },
        {
            value = "¢€𤭢",
            valid = true
        },
        {
            value = "Pay in €. Thanks.",
            valid = true
        },
        {
            value = "lua程序\x81\x01设计",
            valid = false,
            invalid_pos = 10
        },
    }

    for _, case in ipairs(cases) do
        local valid, invalid_pos = self.utf8.validate(case.value)
        luaunit.assertEquals(valid, case.valid)
        if case.invalid_pos then
            luaunit.assertEquals(invalid_pos, case.invalid_pos)
        end
    end

end


function TestLuaUtf8:testUtf8Len()
    local cases = {
        {
            value = "",
            expect = 0
        },
        {
            value = "lua程序设计",
            expect = 7
        },
        {
            value = "¢€𤭢",
            expect = 3
        },
        {
            value = "lua程序\x81\x01设计",
            expect = 5,
            invalid_pos = 10
        },
    }

    for _, case in ipairs(cases) do
        local len, invalid_pos = self.utf8.len(case.value)
        luaunit.assertEquals(len, case.expect)
        if case.invalid_pos then
            luaunit.assertEquals(invalid_pos, case.invalid_pos)
        end
    end
end


function TestLuaUtf8:testUtf8Reverse()
    local cases = {
        {
            value = "a",
            expect = "a"
        },
        {
            value = "lua",
            expect = "aul"
        },
        {
            value = "lua程序设计",
            expect = "计设序程aul"
        }
    }

    for _, case in ipairs(cases) do
        local s = self.utf8.reverse(case.value)
        luaunit.assertEquals(s, case.expect)
    end
end


function TestLuaUtf8:testUtf8Sub()
    local cases = {
        {
            value = "lua程序设计",
            start_pos = 1,
            end_pos = 5,
            expect = "lua程序"
        },
        {
            value = "lua程序设计",
            start_pos = 3,
            expect = "a程序设计"
        },
        {
            value = "lua程序设计",
            start_pos = 20,
            expect = ""
        },
    }

    for _, case in ipairs(cases) do
        local s = self.utf8.sub(case.value, case.start_pos, case.end_pos)
        luaunit.assertEquals(s, case.expect)
    end
end


os.exit(luaunit.run())
