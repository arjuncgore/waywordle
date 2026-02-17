-- ==== IMPORTS
local waywall = require("waywall")
local M = {}
local helpers = require("ww_wordle.helpers")
local words = require("ww_wordle.words")

local cur_word = ""

-- ==== Return? idk
M.setup = function(config, cfg)
    -- Save original remaps
    local og_remaps = helpers.original_remaps(config)

    local chosen_word = words[math.random(14855)]

    helpers.typing_actions(config.actions)
end

return M
