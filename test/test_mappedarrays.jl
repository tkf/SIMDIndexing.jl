module TestMappedArrays

using Test
using SIMDIndexing

include("../examples/vdot.jl")
using MappedArrays

arr1 = randn(2^20)
arr2 = randn(2^20)
f1(x) = x*x + x
f2(x) = x*x*x + 1
ma1 = mappedarray(f1, arr1)
ma2 = mappedarray(f2, arr2)

@test vdot(ma1, ma2) ≈ vdot(f1.(arr1), f2.(arr2))

end  # module
