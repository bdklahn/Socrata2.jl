using URIs

@testset "urls.jl" begin
    @test string(endpoint_metadata_url(test_endpoint1))  == "http://healthdata.gov/api/views/metadata/v1"
    @test string(metadata_url(test_endpoint1, test_id1)) == "http://healthdata.gov/api/views/metadata/v1/anag-cw7u.json"
    @test string(data_url(test_endpoint1, test_id1))     == "http://healthdata.gov/resource/anag-cw7u.csv"
end