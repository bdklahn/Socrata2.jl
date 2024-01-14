"API Version"
const v = "v1"

@enum API catalog resource metadata viewmetadata revision config permissions

"explore all the datasets on domains"
catalog

"a particular data set, usually retrievable as csv or json"
resource

"data about a particular dataset view"
metadata

"current detailed data about a particular dataset view, including column metadata"
viewmetadata

"""
API for starting drafts of view changes, generating endpoints to
associate source data, and publishing.
"""
revision

"API to support schema setting (transformations, etc.) on source data"
config


@enum SUFFIX json csv geojson

"json ouput (.json)"
json

"csv output (.csv)"
csv

"geojson output (.json)"
geojson
