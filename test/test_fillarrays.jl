module TestFillArrays

using Test
using SIMDIndexing

include("../examples/vdot.jl")
using LinearAlgebra
using FillArrays

arr1 = randn(2^20)
arr2 = Ones{Float64}(length(arr1))

@test vdot(arr1, arr2) ≈ dot(arr1, arr2)

end  # module
