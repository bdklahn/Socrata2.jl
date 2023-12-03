@enum SUFFIX csv json geojson

"""
Return URI for data
on an domain.
See https://dev.socrata.com/docs/authentication.html
for userinfo.
"""
function data_url(domain::String, id::String="";
    userinfo::String="",
    path::String="/resource",
    suffix::SUFFIX=csv
    )

    path = !isempty(id) ? joinpath(path, "$(id).$suffix") : path

    URI(
        ;
        scheme="https",
        userinfo=userinfo,
        host=domain,
        path=path,
        )
end

"""
Return the metadata URI for a dataset or domain.
"""
function metadata_url(domain::String, id::String=""; userinfo::String="")
    data_url(
        domain, id;
        userinfo=userinfo,
        path="/api/views/metadata/v1",
        suffix=json,
        )
end
