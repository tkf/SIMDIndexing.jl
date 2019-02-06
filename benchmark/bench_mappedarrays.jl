module BenchMappedArrays

using SIMDIndexing

include("../examples/vdot.jl")
using LinearAlgebra
using MappedArrays
using BenchmarkTools

suite = BenchmarkGroup()

arr1 = randn(2^20)
arr2 = randn(2^20)
f1(x) = x*x + x
f2(x) = x*x*x + 1
ma1 = mappedarray(f1, arr1)
ma2 = mappedarray(f2, arr2)

suite["fused"] = @benchmarkable vdot($ma1, $ma2)
suite["nonfused"] = @benchmarkable begin
    a1 = $(similar(arr1))
    a2 = $(similar(arr2))
    copyto!(a1, $ma1)
    copyto!(a2, $ma2)
    vdot(a1, a2)
end
suite["dot"] = @benchmarkable dot($ma1, $ma2)

function main()
    global results = run(suite; verbose = true)
    show(IOContext(stdout, :compact => false), results)

    println()
    println()
    println("Benchmark result is stored in $(@__MODULE__).results")

    println()
    println("fused vs nonfused")
    display(judge(minimum.((results["fused"], results["nonfused"]))...))

    println("fused vs dot")
    display(judge(minimum.((results["fused"], results["dot"]))...))
end

end  # module
BenchMappedArrays.suite
