module Socrata2

using URIs
using HTTP
using JSON3
using CSV
using Arrow

export catalog, resource, metadata, publishing, permissions
export url, get_data, get_metadata, get_dataset, save
export csv, json, geojson
export to_string_pairs

hello_world() = "Hello World!"

include("urls.jl")
include("get.jl")

end
