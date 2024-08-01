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
        "Running" => [
             "Overview" => "Running.md",
             "Single workflow parameters" => "Running_singleworkflow_params.md",
             "Multiple workflows parameters" => "Running_multipleworkflow_params.md"
             ],
        "DoViP projects and outputs" => [
            "Project definition" => "dovip_projects.md",
            "Outputs - overview" => "dovip_outputs_overview.md",
            "Outputs - step by step breakdown" => "dovip_outputs_stepbystep.md",
            ]
    ],
)