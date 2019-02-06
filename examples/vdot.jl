using SIMD

@inline function vdot(xs, ys, ::Type{Vec{N,T}} = Vec{4,Float64}) where {N,T}
    @assert length(ys) == length(xs)
    @assert length(xs) % N == 0
    lane = VecRange{N}(0)
    vacc = zero(Vec{N, T})
    @inbounds for i in 1:N:length(xs)
        vacc = muladd(xs[lane + i], ys[lane + i], vacc)
    end
    return sum(vacc)
end
