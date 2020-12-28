local sbyte = string.byte
local ssub = string.sub
local concat = table.concat
local abs = math.abs


local _M = {}


-- Accept range for utf8
local accept_range = {
  {lo = 0x80, hi = 0xBF},
  {lo = 0xA0, hi = 0xBF},
  {lo = 0x80, hi = 0x9F},
  {lo = 0x90, hi = 0xBF},
  {lo = 0x80, hi = 0x8F}
}


-- Check the given string is a valid utf8 string.
--
-- Args:
--   str: string
-- Returns:
--   (bool) whether the input string is a valid utf8 string.
--   (number) position of the first invalid byte if given.
function _M.validate(str)
    local i, n = 1, #str
    local first, byte, left_size, range_idx

    while i <= n do
        first = sbyte(str, i)
        if first >= 0x80 then
            range_idx = 1
            if first >= 0xC2 and first <= 0xDF then --2 bytes
                left_size = 1
            elseif first >= 0xE0 and first <= 0xEF then --3 bytes
                left_size = 2
                if first == 0xE0 then
                    range_idx = 2
                elseif first == 0xED then
                    range_idx = 3
                end
            elseif first >= 0xF0 and first <= 0xF4 then --4 bytes
                left_size = 3
                if first == 0xF0 then
                    range_idx = 4
                elseif first == 0xF4 then
                    range_idx = 5
                end
            else
                return false, i
            end

            if i + left_size > n then
                return false, i
            end

            for j = 1, left_size do
                byte = sbyte(str, i + j)
                if byte < accept_range[range_idx].lo or byte > accept_range[range_idx].hi then
                    return false, i
                end
                range_idx = 1
            end
            i = i + left_size
        end
        i = i + 1
    end

    return true
end


-- Get the given string len.
--
-- Args:
--   str: string
-- Returns:
--   (number) the length of valid utf8 string part.
--   (number) position of the first invalid byte if given.
function _M.len(str)
    local i, n, c = 1, #str, 0
    local first, byte, left_size, range_idx

    while i <= n do
        first = sbyte(str, i)
        if first >= 0x80 then
            range_idx = 1
            if first >= 0xC2 and first <= 0xDF then --2 bytes
                left_size = 1
            elseif first >= 0xE0 and first <= 0xEF then --3 bytes
                left_size = 2
                if first == 0xE0 then
                    range_idx = 2
                elseif first == 0xED then
                    range_idx = 3
                end
            elseif first >= 0xF0 and first <= 0xF4 then --4 bytes
                left_size = 3
                if first == 0xF0 then
                    range_idx = 4
                elseif first == 0xF4 then
                    range_idx = 5
                end
            else
                return c, i
            end

            if i + left_size > n then
                return c, i
            end

            for j = 1, left_size do
                byte = sbyte(str, i + j)
                if byte < accept_range[range_idx].lo or byte > accept_range[range_idx].hi then
                    return c, i
                end
                range_idx = 1
            end
            i = i + left_size
        end
        i = i + 1
        c = c + 1
    end

    return c
end


-- Reverse the given valid utf8 string.
-- Args:
--   str: string
-- Returns:
--   (string) a reversed utf8 string of the given string.
function _M.reverse(str)
    if #str <= 1 then
        return str
    end

    local i, n, c = 1, #str, 0
    local first, left_size
    local utf8_arr = {}

    while i <= n do
        first = sbyte(str, i)
        left_size = 0
        if first >= 0x80 then
            if first >= 0xC2 and first <= 0xDF then --2 bytes
                left_size = 1
            elseif first >= 0xE0 and first <= 0xEF then --3 bytes
                left_size = 2
            elseif first >= 0xF0 and first <= 0xF4 then --4 bytes
                left_size = 3
            end
        end
        c = c + 1
        utf8_arr[c] = ssub(str, i, i + left_size)
        i = i + left_size + 1
    end

    for j = 1, (c + 1) / 2 do
        utf8_arr[c - j + 1], utf8_arr[j] = utf8_arr[j], utf8_arr[c - j + 1]
    end

    return concat(utf8_arr)
end


-- Sub the given valid utf8 string with the given index.
-- Args:
--   str: string
--   s: number, start index of utf8 character
--   e: number, end index of utf8 character
-- Returns:
--   (string) utf8 sub string
function _M.sub(str, s, e)
    local len = _M.len(str)
    e = e or len
    local utf8_start = s >= 0 and s or len - abs(s) + 1
    local utf8_end  = e >= 0 and e or len - abs(e) + 1

    if utf8_end > len then
        utf8_end = len
    end

    if utf8_start > len or
        utf8_start <= 0 or
        utf8_end <= 0 then
        return ""
    end

    local i, c = 1, 0
    local first, left_size, byte_start, byte_end

    while c < len do
        first = sbyte(str, i)
        left_size = 0
        if first >= 0x80 then
            if first >= 0xC2 and first <= 0xDF then --2 bytes
                left_size = 1
            elseif first >= 0xE0 and first <= 0xEF then --3 bytes
                left_size = 2
            elseif first >= 0xF0 and first <= 0xF4 then --4 bytes
                left_size = 3
            end
        end
        c = c + 1

        if c == utf8_start then
            byte_start = i
        end

        if c == utf8_end then
            byte_end = i + left_size
        end

        i = i + left_size + 1

    end

    return ssub(str, byte_start, byte_end)
end


return _M
