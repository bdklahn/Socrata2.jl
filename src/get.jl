struct DataSet
    data::Union{JSON3.Object,JSON3.Array,CSV.File}
    metadata::JSON3.Object
end

"""
Convert to format where string pairs are useful or needed.
E.g. url headers or Arrow metadata
"""
to_string_pairs(dict_like) = [string(p.first) => string(p.second) for p in pairs(dict_like)]

"""
Get data from a Socrata endpoint. This might be resource data,
metadata, or data returned about creating view revisions or 
connecting source data to those revisions, etc., depending on the
api used.
"""
function get_data(domain, id;
    userinfo="", headers=Vector{Pair{String, String}}(), suffix=json, kwargs...
    )
    query = to_string_pairs(kwargs)
    if userinfo != "" push!(headers, "Authorization" => "Basic $userinfo") end
    this_url = url(domain, id;suffix, kwargs...)
    @show this_url
    suffix == csv ? CSV.File(HTTP.get(this_url; headers, query).body, downcast=true) :
                    JSON3.read(HTTP.get(this_url; headers, query).body)
end

function get_dataset(domain, id;
    userinfo="", headers=Vector{Pair{String, String}}(), suffix=json, kwargs...
    )
    DataSet(
        get_data(domain, id; userinfo, headers, suffix, kwargs...),
        get_data(domain, id; userinfo, headers, suffix=json, api=metadata,kwargs...)
    )
end

function save(dataset::DataSet, outdir::String="./"; arrow::Bool=false)
    (;data, metadata) = dataset
    filepath = joinpath(outdir, "$(metadata[:domain]).$(metadata[:id])")
    if arrow && isa(data, CSV.File)
        Arrow.write("$filepath.arrow", data)
    else
        if isa(data, CSV.File)
            CSV.write("$filepath.csv", data)
        else
            open("$filepath.json", "w") do io
                JSON3.pretty(io, data)
            end
        end
        open("$(filepath)_metadata.json", "w") do io
            JSON3.pretty(io, metadata)
        end
    end
end