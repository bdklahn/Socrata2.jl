"""
Get metadata about a data set or endpoint.
returns: JSON3.Array
"""
function get_metadata(endpoint::String, id::String=""; userinfo::String="")
    JSON3.read(HTTP.get(metadata_url(endpoint, id; userinfo=userinfo)).body)
end

"""
Get data set data.
Return type dependent on suffix.
"""
function get_data(endpoint::String, id::String=""; userinfo::String="", suffix::SUFFIX=csv)
    uri = data_url(endpoint, id; userinfo=userinfo, suffix=suffix)
    suffix == csv                  ? CSV.File(HTTP.get(uri).body)   :
    suffix == json || s == geojson ? JSON3.read(HTTP.get(uri).body) :
    nothing
end