local M = {}

function print_table(t)
    for i = 1, #t do
        io.write(t[i] .. " ")
    end
    io.write("\n")
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

print_table(M.score_word("scare", "apple"))
