"""
Convert to format where string pairs are useful or needed.
E.g. url headers or Arrow metadata
Add prefix, e.g. when Socrata query key needs \$.
"""
function to_string_pairs(dict_like, prefix="")
    new_pairs = []
    for pr in pairs(dict_like)
        first = string(pr.first)
        if !isempty(prefix) && !startswith(first, prefix) first = prefix * first end
        second = string(pr.second)
        append!(new_pairs, (first => second,))
    end
    new_pairs
end

macro varname(v) string(v) end