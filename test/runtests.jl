module TestSIMDIndexing
using Test

@testset "$file" for file in [
        "test_mappedarrays.jl",
        "test_fillarrays.jl",
        "test_ambiguity.jl",
        ]
    include(file)
end

@test false

end  # module
