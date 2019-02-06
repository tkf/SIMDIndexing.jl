using Test

_modulenames = quote
    SIMD
    MappedArrays
    SIMDIndexing
end
modulenames = [x for x in _modulenames.args if x isa Symbol]
@debug "Loading dependencies:" modulenames
for m in modulenames
    @eval import $m
end

modules = eval.(modulenames)
ambiguities = detect_ambiguities(modules..., imported=true, recursive=true)
@test ambiguities == []
