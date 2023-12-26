@enum API catalog resource metadata revision config permissions
@enum SUFFIX csv json geojson
const vers = "v1"

function url(domain::String, id::String="";
    api::API=resource, suffix::SUFFIX=json, kwargs...
    )
    a, s = string(api), string(suffix)
    api_path = 
    api === resource && id != "" ?       joinpath("/resource", "$id.$s") :
    api === metadata ?                   joinpath("/api/views", a, vers, id) :
    api === revision || api === config ? joinpath("/api/publishing", vers, a) :
    api === permissions ?                joinpath("/api/views", id, a) :
                                         joinpath("/catalog", vers)

    URI(;scheme="https", host=domain, path=api_path,)
end
