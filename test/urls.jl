using URIs

@testset "urls.jl" begin
    @test string(metadata_url(test_domain1))           == "https://@$test_domain1/api/views/metadata/v1"
    @test string(metadata_url(test_domain1, test_id1)) == "https://@$test_domain1/api/views/metadata/v1/$test_id1.json"
    @test string(data_url(test_domain1, test_id1))     == "https://@$test_domain1/resource/$test_id1.csv"
end