module Socrata2

using URIs

export metadata_url
export endpoint_metadata_url
export data_url

hello_world() = "Hello World!"

include("urls.jl")

end
