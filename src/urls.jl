"""
Generate standard URI's for Socrata endpoints.
"""
function url(domain::String, id::String="";
    api::API=resource, suffix::SUFFIX=json,
    query::String="\$limit=9999999",
    kwargs...
    )
    j, a, s = joinpath, string(api), string(suffix)

    path =
    api === resource && id != "" ?     j("/resource", "$id.$s") :
    api === metadata ?                 j("/api/views", a, v, id) :
    api === viewmetadata && id != "" ? j("/api/views", id) :
    api in (revision, config) ?        j("/api/publishing", v, a) :
    api === permissions ?              j("/api/views", id, a) :
                                       j("/catalog", v)

    if !isempty(kwargs)
        query *= "&$(escapeuri(kwargs))"
        # use unique dictionay keys to get rid of
        # redunant params (Socrata will error)
        query = escapeuri(to_string_pairs(queryparams(query), "\$"))
    end

    URI(;scheme="https", host=domain, path, query)
end
