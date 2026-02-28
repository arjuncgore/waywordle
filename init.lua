local waywall  = require("waywall")
local M        = {}
local helpers  = require("goredle.helpers")
local words    = require("goredle.words")

local state = {
    active = false,
    cur_word = "",
    cur_word_handle = nil,
    target_word = nil,
    og_remaps = nil,
    og_actions = nil,

    guesses = {},
    scores = {},
    row_handles = {},
    info_handle = nil,
}

local function start_wordle(config)
    if state.active then return end
    state.active = true

    state.og_remaps  = helpers.original_remaps(config)
    state.og_actions = helpers.original_cactions(config)

    math.randomseed(os.time())
    state.target_word = words[math.random(#words)]
    print("Target Word: " .. state.target_word)

    state.cur_word = ""
    state.cur_word_handle = helpers.update_cur_word(
        state.cur_word,
        state.cur_word_handle,
        { x = 100, y = 100 }
    )

    -- install typing + backspace into current config.actions
    helpers.typing_actions(config, state, { x = 100, y = 100 })

    -- (optional) add Enter handler here later
end

local function stop_wordle(config)
    if not state.active then return end
    state.active = false

    -- restore remaps
    config.input.remaps = state.og_remaps

    -- restore actions (this also removes typing actions)
    helpers.restore_cactions(config, state.og_actions)

    if state.cur_word_handle then
        state.cur_word_handle:close()
        state.cur_word_handle = nil
    end
end

M.setup = function(config)
    config.actions["Shift+L"] = function()
        start_wordle(config)
    end

    config.actions["Shift+K"] = function()
        stop_wordle(config)
    end
end

return M
