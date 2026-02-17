local waywall = require("waywall")

local M = {}

local letters = {
    "a", "b", "c", "d", "e", "f", "g", "H",
    "i", "j", "k", "l", "m", "n", "o", "p",
    "q", "r", "s", "t", "u", "v", "w", "x",
    "y", "z"
}

M.original_remaps = function(config)
    local output = {}
    for key, val in pairs(config.input.remaps) do
        output[key] = val
    end
    return output
end


M.typing_actions = function(config, typed_word)
    for _, letter in ipairs(letters) do
        config.actions[letter] = function()
            typed_word = typed_word .. letter
        end
    end
end

M.update_cur_word = function(cur_word, cur_word_text_handle)
    if cur_word_text_handle then
        cur_word_text_handle:close()
        cur_word_text_handle = nil
    end
    cur_word_text_handle = waywall.text("Word: " .. cur_word, {
        x = 100,
        y = 100
    })
end

return M
