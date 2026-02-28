local waywall = require("waywall")
local words = require("goredle.words")

local M = {}

local letters = {
    "a", "b", "c", "d", "e", "f", "g", "h",
    "i", "j", "k", "l", "m", "n", "o", "p",
    "q", "r", "s", "t", "u", "v", "w", "x",
    "y", "z"
}

function M.original_remaps(config)
    local output = {}
    for key, val in pairs(config.input.remaps or {}) do
        output[key] = val
    end
    return output
end

function M.original_cactions(config)
    local output = {}
    for key, val in pairs(config.actions or {}) do
        output[key] = val
    end
    return output
end

function M.restore_cactions(config, og_actions)
    config.actions = {}
    for k, v in pairs(og_actions or {}) do
        config.actions[k] = v
    end
end


function M.typing_actions(config, state, options)
    for _, letter in ipairs(letters) do
        config.actions[letter] = function()
        if not state.active then
            return
        end
        if #state.cur_word >= 5 then return end
            state.cur_word = state.cur_word .. letter
            state.cur_word_handle = M.update_cur_word(state.cur_word, state.cur_word_handle, options)
        end
    end

    config.actions["BackSpace"] = function()
        if not state.active then return end
        state.cur_word = state.cur_word:sub(1, math.max(0, #state.cur_word - 1))
        state.cur_word_handle = M.update_cur_word(state.cur_word, state.cur_word_handle, options)
    end
end

function M.update_cur_word(cur_word, cur_word_text_handle, options)
    if cur_word_text_handle then
        cur_word_text_handle:close()
    end
    return waywall.text("Word: " .. cur_word, options)
end

function M.contains_word(word)
    for _, w in ipairs(words) do
        if w == word then return true end
    end
    return false
end

function M.score_word(word, target)
    -- 0 = not in word, 1 = in word wrong place, 2 = in word right place
    local score = {0, 0, 0, 0, 0}


    -- mark greens (2)
    local remaining = {} -- stores rest of letters
    for i = 1, 5 do
        local wchar = word:sub(i, i)
        local tchar = target:sub(i, i)

        if wchar == tchar then
            score[i] = 2
        else
            remaining[tchar] = (remaining[tchar] or 0) + 1
        end
    end

    -- mark yellows (1)
    for i = 1, 5 do
        if score[i] == 0 then
            local wchar = word:sub(i, i)

            if remaining[wchar] and remaining[wchar] > 0 then
                score[i] = 1
                remaining[wchar] = remaining[wchar] - 1
            end
        end
    end

    return score
end
return M
