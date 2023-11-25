"""
Get metadata about the entire endpoint.
returns: JSON3.Array
"""
function get_metadata(endpoint::String)
    JSON3.read(HTTP.get(endpoint_metadata_url(endpoint)).body)
end