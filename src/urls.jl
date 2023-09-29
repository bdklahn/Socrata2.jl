const metadata_path = "api/views/metadata/v1"
const data_path = "resource"


"""
Return the metadata URI for a dataset.
"""
function metadata_url(endpoint::String, id::String)
    URI("http://$(endpoint)/$(metadata_path)/$(id).json")
end

