module Socrata2

using URIs
using HTTP
using JSON3
using CSV

export metadata_url
export data_url
export csv, json, geojson
export get_metadata
export get_data

hello_world() = "Hello World!"

include("urls.jl")
include("get.jl")

end
