using Documenter

makedocs(;
    #modules=[DoViP_App],
    authors="Cristina Moraru <lilianacristina.moraru@uni-due.de>",
    sitename="DoViP",
    format=Documenter.HTML(;
        edit_link="main",
        assets=String[],
        inventory_version="0.1.0"
    ),
    pages=[
        "Home" => "index.md",
        "Installation" => [
             "Overview" => "Installation.md", 
             "Dependencies" => "installation_conda_dependencies.md",
             "DoViP environment" => "installation_DoViP_env.md"], 
        "Running" => "Running.md"
    ],
)