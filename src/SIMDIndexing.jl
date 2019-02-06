module SIMDIndexing

using SIMD
using Requires

const VecOfIntegers{N, T <: SIMD.IntegerTypes} = Vec{N, T}

abstract type AbstractIndex end
const Index = Union{Int, VecOfIntegers, VecRange, AbstractIndex}


function __init__()
    @require(MappedArrays="dbb5928d-eab1-5f90-85c2-b9b0edb7c900",
             include("mappedarrays.jl"))
    @require(FillArrays="1a297f60-69ca-5386-bcde-b61e274b549b",
             include("fillarrays.jl"))
end

end # module
