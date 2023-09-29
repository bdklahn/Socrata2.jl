using URIs

@testset "urls.jl" begin
    @test metadata_url(test_endpoint1, test_id1) == URI("http://$(test_endpoint1)/api/views/metadata/v1/$(test_id1).json")
end