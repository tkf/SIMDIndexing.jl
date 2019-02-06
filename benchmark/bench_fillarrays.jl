module BenchFillArrays

using SIMDIndexing

include("../examples/vdot.jl")
# using LinearAlgebra
using FillArrays
using BenchmarkTools

suite = BenchmarkGroup()

arr1 = randn(2^20)
arr2 = Ones{Float64}(length(arr1))

# Bump SIMD width to 16.  It looks like `@simd` macro (or LLVM?) likes
# to unroll loops a lot.  So I have to increase the vector size to
# make the performance comparable.
N = 16

# There is no way `vdot` is faster; but it must not be _slower_.
suite["vdot"] = @benchmarkable vdot($arr1, $arr2, $(Vec{N, Float64}))
suite["sum"] = @benchmarkable sum($arr1)
# suite["dot"] = @benchmarkable dot($arr1, $arr2)

function main()
    global results = run(suite; verbose = true)
    show(IOContext(stdout, :compact => false), results)

    println()
    println()
    println("Benchmark result is stored in $(@__MODULE__).results")

    println("vdot vs sum")
    display(judge(minimum.((results["vdot"], results["sum"]))...))
end

end  # module
BenchFillArrays.suite
