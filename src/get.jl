struct DataSet
    data::Union{JSON3.Object,JSON3.Array,CSV.File}
    metadata::JSON3.Object
    viewmetadata::JSON3.Object
end

"""
Get data from a Socrata endpoint. This might be resource data,
metadata, or data returned about creating view revisions or 
connecting source data to those revisions, etc., depending on the
api used.
"""
function get_data(domain, id;
    userinfo="", headers=Vector{Pair{String, String}}(), suffix=json, kwargs...
    )
    if userinfo != "" push!(headers, "Authorization" => "Basic $userinfo") end
    @show this_url = url(domain, id;suffix, kwargs...)
    suffix == csv ? CSV.File(HTTP.get(this_url; headers).body, downcast=true) :
                    JSON3.read(HTTP.get(this_url; headers).body)
end

function get_dataset(domain, id;
    userinfo="", headers=Vector{Pair{String, String}}(), suffix=json, kwargs...
    )
    DataSet(
        get_data(domain, id; userinfo, headers, suffix, kwargs...),
        get_data(domain, id; userinfo, headers, suffix=json, api=metadata,kwargs...),
        get_data(domain, id; userinfo, headers, suffix=json, api=viewmetadata,kwargs...)
    )
end

function save(dataset::DataSet, outdir::String="./"; arrow::Bool=false)
    (;data, metadata, viewmetadata) = dataset
    filepath = joinpath(outdir, "$(metadata[:domain]).$(metadata[:id])")
    if arrow && isa(data, CSV.File)
        viewmetadata = Dict(viewmetadata)
        columns = pop!(viewmetadata, :columns)
        colmetadata = Dict()
        for col in columns
            col = Dict(col)
            key = Symbol(pop!(col, :fieldName))
            colmetadata[key] = to_string_pairs(col)
        end
        metadata = to_string_pairs(
            merge(viewmetadata, metadata)
            )
        Arrow.write("$filepath.arrow", data; colmetadata, metadata)
    else
        if isa(data, CSV.File)
            CSV.write("$filepath.csv", data)
        else
            open("$filepath.json", "w") do io
                JSON3.pretty(io, data)
            end
        end
        open("$(filepath)_metadata.json", "w") do io
            JSON3.pretty(io, merge(viewmetadata, metadata))
        end
    end
end