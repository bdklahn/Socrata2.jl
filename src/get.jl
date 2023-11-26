"""
Convert "slurped" `kwargs` from a named tuple
to an iterable of string pairs, including the expected \$
before the key.
"""
function format_query(query)
    ("\$$(string(x[1]))" => string(x[2]) for x in zip(keys(query), values(query)))
end

"""
Get metadata about a data set or endpoint.
returns: JSON3.Array
"""
function get_metadata(endpoint::String, id::String=""; userinfo::String="", kwargs...)
    query = format_query(kwargs)
    JSON3.read(HTTP.get(metadata_url(endpoint, id; userinfo=userinfo); query=query).body)
end

"""
Get data set data.
Return type dependent on suffix.
"""
function get_data(endpoint::String, id::String=""; userinfo::String="", suffix::SUFFIX=csv, kwargs...)
    uri = data_url(endpoint, id; userinfo=userinfo, suffix=suffix)
    query = format_query(kwargs)
    suffix == csv                       ? CSV.File(HTTP.get(uri; query=query).body)   :
    suffix == json || suffix == geojson ? JSON3.read(HTTP.get(uri; query=query).body) :
    nothing
end