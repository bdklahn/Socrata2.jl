using Socrata2, Test, URIs, CSV, JSON3

const dir = joinpath(dirname(pathof(Socrata2)), "..", "test")

const test_endpoint1 = "healthdata.gov"
const test_id1 = "anag-cw7u"

@testset "Socrata2.jl" begin
    for f in [
        "urls.jl",
        "get.jl",
        ]
        file = joinpath(dir, f)
        println("Running $file tests...")
        if isfile(file)
            include(file)
        else
            @show readdir(dirname(file))
        end
    end
end