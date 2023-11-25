"""
Get metadata about a data set or endpoint.
returns: JSON3.Array
"""
function get_metadata(endpoint::String, id::String=""; userinfo::String="")
    JSON3.read(HTTP.get(metadata_url(endpoint, id; userinfo=userinfo)).body)
end
