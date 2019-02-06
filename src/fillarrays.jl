module SIMDIndexingFillArrays

using Base: checkbounds

using ..SIMDIndexing: Index
using ..SIMDIndexing.FillArrays: AbstractFill, getindex_value

# It's probably semantically better to return a `Vec` here but I don't
# want to waste SIMD registers...  It's perhaps the best to add
# `VecFill` type but returning number works most of the time.

@inline function Base.getindex(F::AbstractFill, k::Index)
    @boundscheck checkbounds(F, k)
    getindex_value(F)
end

@inline function Base.getindex(F::AbstractFill{T, N}, kj::Vararg{<:Index, N}) where {T, N}
    @boundscheck checkbounds(F, kj...)
    getindex_value(F)
end

end  # module
