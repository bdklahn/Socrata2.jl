"""
Get metadata about the entire endpoint.
returns: JSON3.Array
"""
function get_metadata(endpoint::String)
    JSON3.read(HTTP.get(endpoint_metadata_url(endpoint)).body)
end

"""
Get metadata about a data set.
returns: JSON3.Array
"""
function get_metadata(endpoint::String, id::String)
    JSON3.read(HTTP.get(metadata_url(endpoint, id)).body)
end