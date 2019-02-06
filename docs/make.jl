using Documenter, SIMDIndexing

makedocs(;
    modules=[SIMDIndexing],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/tkf/SIMDIndexing.jl/blob/{commit}{path}#L{line}",
    sitename="SIMDIndexing.jl",
    authors="Takafumi Arakaki",
    assets=[],
)

deploydocs(;
    repo="github.com/tkf/SIMDIndexing.jl",
)
