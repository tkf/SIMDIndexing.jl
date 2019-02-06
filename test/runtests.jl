module TestSIMDIndexing
using Test

@testset "$file" for file in [
        "test_ambiguity.jl",
        ]
    include(file)
end

end  # module
