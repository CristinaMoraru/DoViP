module DoViP_App

using Revise
using BioS_ProjsWFs: initialize_workflow
using DoViP_Lib

args = ARGS


if "--help" in args
    println("DoViP - a workflow for virus prediction in metagenomes.")
    cur_proj = dirname(Base.active_project())
    print(read("$(cur_proj)/README.md", String))
    exit()
end

println("Start DoViP!")
proj = initialize_workflow(args, ProjSViP_fun)

if proj.projtype == "singleworkflow"
    run_workflow(proj)
elseif proj.projtype == "multipleworkflow"
    run_workflowMDoViP(proj)
end

println("DoVip is done!")

end # module DoViP_App




