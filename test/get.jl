
@testset "get.jl" begin
    @test get_metadata(test_endpoint1, test_id1)[:id]  == "anag-cw7u"
end