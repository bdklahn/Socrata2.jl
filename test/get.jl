
@testset "get.jl" begin
    @test get_metadata(test_endpoint1, test_id1)[:id]  == test_id1
    @test isa(get_data(test_endpoint1, test_id1), CSV.File)
    @test isa(get_data(test_endpoint1, test_id1; suffix=json), JSON3.Array)
end