const metadata_path = "api/views/metadata/v1"
const data_path = "resource"
@enum SUFFIX csv json geojson

"""
Return URI for information about all the data
sets on an endpoint.
"""
function endpoint_metadata_url(endpoint::String)
    URI("http://$endpoint/$metadata_path")
end

"""
Return the metadata URI for a dataset.
"""
function metadata_url(endpoint::String, id::String)
    URI(string(endpoint_metadata_url(endpoint)) * "/$(id).json")
end

function data_url(endpoint::String, id::String, suffix::SUFFIX=csv)
    URI("http://$endpoint/$data_path/$(id).$suffix")
end