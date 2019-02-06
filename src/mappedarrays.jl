module SIMDIndexingMappedArrays

using Base: @propagate_inbounds

using ..SIMDIndexing: Index
using ..SIMDIndexing.MappedArrays
using ..SIMDIndexing.MappedArrays: _getindex, _setindex!,
    AbstractMultiMappedArray, MultiMappedArray

# IndexLinear implementations
@inline @propagate_inbounds Base.getindex(A::AbstractMappedArray, i::Index) =
    A.f(A.data[i])
@inline @propagate_inbounds Base.getindex(M::AbstractMultiMappedArray, i::Index) =
    M.f(_getindex(i, M.data...)...)

@inline @propagate_inbounds function Base.setindex!(A::MappedArray{T},
                                                    val,
                                                    i::Index) where {T}
    A.data[i] = A.finv(convert(T, val)::T)
end
@inline @propagate_inbounds function Base.setindex!(A::MultiMappedArray{T},
                                                    val,
                                                    i::Index) where {T}
    vals = A.finv(convert(T, val)::T)
    _setindex!(A.data, vals, i)
    return vals
end


# IndexCartesian implementations
@inline @propagate_inbounds function Base.getindex(A::AbstractMappedArray{T,N},
                                                   i::Vararg{Index,N}) where {T,N}
    A.f(A.data[i...])
end
@inline @propagate_inbounds function Base.getindex(A::AbstractMultiMappedArray{T,N},
                                                   i::Vararg{Index,N}) where {T,N}
    A.f(_getindex(CartesianIndex(i), A.data...)...)
end

@inline @propagate_inbounds function Base.setindex!(A::MappedArray{T,N},
                                                    val,
                                                    i::Vararg{Index,N}) where {T,N}
    A.data[i...] = A.finv(convert(T, val)::T)
end
@inline @propagate_inbounds function Base.setindex!(A::MultiMappedArray{T,N},
                                                    val,
                                                    i::Vararg{Index,N}) where {T,N}
    vals = A.finv(convert(T, val)::T)
    _setindex!(A.data, vals, i...)
    return vals
end

end # module
