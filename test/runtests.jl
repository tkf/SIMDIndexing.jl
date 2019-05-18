#!/bin/bash
# -*- mode: julia -*-
#=
JULIA="${JULIA:-julia}"
JULIA_CMD="${JULIA_CMD:-${JULIA} --color=yes --startup-file=no}"

JULIA_PROJECT="$(dirname "${BASH_SOURCE[0]}")"
export JULIA_PROJECT

exec ${JULIA_CMD} "$@" "${BASH_SOURCE[0]}"
=#

module TestSIMDIndexing
using Test

@testset "$file" for file in [
        "test_mappedarrays.jl",
        "test_fillarrays.jl",
        "test_ambiguity.jl",
        ]
    include(file)
end

end  # module
