using DoViP_App
using Documenter

DocMeta.setdocmeta!(DoViP_App, :DocTestSetup, :(using DoViP_App); recursive=true)

makedocs(;
    modules=[DoViP_App],
    authors="Cristina Moraru <lilianacristina.moraru@uni-due.de>",
    sitename="DoViP_App.jl",
    format=Documenter.HTML(;
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)
