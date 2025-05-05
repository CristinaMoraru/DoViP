module DoViP_App

using Revise
using BioS_ProjsWFs: initialize_workflow
using DoViP_Lib

args = ARGS


if "--help" in args
    println("DoViP - a workflow for virus prediction in metagenomes.")
    show_file_content("../README.md")
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




#region for testing 

#= ProjSViP - a single virus prediction workflow
args = [
    "projtype=singleworkflow",
    "pd_prefix=/data3/CLM_projs/TEST_Workflows/DoViP0.8_extres_VV_relp_log_columnOrder_useextAll", 
    "inref=/data3/CLM_projs/TEST_Workflows/inDoViP/Sulfitobacter_M_183_191_265_CRM.fasta",  #/data3/CLM_projs/TEST_Workflows/inDoViP/Sulfitobacter_M_183_191_265_CRM.fasta",
    "sample_set=Test",
    "use_slurm=false",
    "stop_after_initial_predictors=false",
    "continue=true",
    "min_contig_length=1000",

    "genomad_signal=ignore",
    "genomad_res=/data3/CLM_projs/TEST_Workflows/DoViP0.8_extres_VV_relp_log_columnOrder/Sulfitobacter_M_183_191_265_CRM/ALL-01a_genomad/ALL-01a_01_genomad_out/",
    "genomad_env=conda_genomad",
    "genomadDB_p=/mnt/XIO_3/data1/genomad_db/genomad_db/",
    "genomad_min_score=0.7",  #default in genomad is 0.7, value between 0 and 1. 
    "genomad_sbatch_time=2-0",  #(days-hours)
    "genomad_cpus_per_task=25",
    "genomad_sbatch_mem=20G",

    "DVF_signal=ignore",
    "DVF_env=conda_DVF",
    "DVF_maxContigLen=2099000", #2099000
    "DVF_scoreTh=0.7",
    "DVF_pThreshold=0.01",
    "DVF_p=/home/conda/software/DeepVirFinder/dvf.py",
    "DVF_sbatch_time=2-0",  #(days-hours)
    "DVF_cpus_per_task=15",
    "DVF_sbatch_mem=20G",


    "virSorter2_signal=ignore",
    "virSorter2_res=/data3/CLM_projs/TEST_Workflows/DoViP0.8_extres_VV_relp_log_columnOrder/Sulfitobacter_M_183_191_265_CRM/ALL-01c_virSorter2/ALL-01c_01_virSorter2_out/",
    "virSorter2_env=conda_virsorter2",
    "virSorter2DB_p=/mnt/XIO_3/data1/virsorter-data/virsorter2/db/"#,yes
    "virSorter2_high_confidence_only=false",
    "virSorter2_min_score=0.5",  #default in virSorter2 is 0.5, value between 0 and 1. ################
    "virSorter2_sbatch_time=4-0",  #(days-hours)
    "virSorter2_cpus_per_task=25",
    "virSorter2_sbatch_mem=20G",


    "vibrant_signal=use",
    "vibrant_res=/data3/CLM_projs/TEST_Workflows/DoViP0.8_extres_VV_relp_log_columnOrder/Sulfitobacter_M_183_191_265_CRM/ALL-01d_vibrant/ALL-01d_01_vibrant_out/",
    "vibrant_env=conda_VIBRANT",
    "vibrant_p=/home/conda/software/VIBRANT/VIBRANT_run.py",
    "vibrantDB_p=/home/conda/software/VIBRANT/databases/",
    "vibrant_sbatch_time=2-0",  #(days-hours)
    "vibrant_cpus_per_task=25",
    "vibrant_sbatch_mem=20G",
    
    "viralVerify_signal=ignore",
    "viralVerify_res=/data3/CLM_projs/TEST_Workflows/DoViP0.8_extres_VV_relp_log_columnOrder/Sulfitobacter_M_183_191_265_CRM/ALL-01e_viralVerify/ALL-01e_01_viralVerify_out", #/data3/CLM_projs/TEST_Workflows/outViralverify",
    "viralVerify_env=conda_viralVerify",
    "viralVerifyDB_p=/software/conda/conda_viralVerify/DB/viralverifyDB_nbc_hmms.hmm",
    "viralVerify_p=/software/conda/conda_viralVerify/viralVerify/bin/viralverify",
    "viralVerfify_threshold=7",
    "viralVerify_sbatch_time=2-0",  #(days-hours)
    "viralVerify_cpus_per_task=25",
    "viralVerify_sbatch_mem=20G",

    #"cenote-taker3_signal=do",
    #"ct3_env=conda_Cenote-Taker3_v3.2.1",

    "checkv_env=conda_checkV",
    "checkvDB_p=/mnt/XIO_3/data1/CheckV/checkv-db-v1.5/",
    "checkv_sbatch_time=2-0",  #(days-hours)
    "checkv_cpus_per_task=2",
    "checkv_sbatch_mem=20G",

    "phaTYP_env=conda_PhaBOX",
    "phaTYP_p=/software/conda/soft/PhaBOX/",
    "phaTYPdb_p=/software/conda/soft/PhaBOX/database/",
    "phaTYPparam_p=/software/conda/soft/PhaBOX/parameters",
    #"phaTYP_minlength=1000",  
    "phaTYP_sbatch_time=2-0",  #(days-hours)
    "phaTYP_cpus_per_task=2",
    "phaTYP_sbatch_mem=20G",
    
    #FINAL Thresholding new
    "NONInt_th_num_predictors_CheckV_NA=3",
    "NONInt_th_num_predictors_CheckV_AAIHighConf=1",
    "NONInt_th_completeness_CheckV_AAIHighConf=30",
    "NONInt_th_num_predictors_CheckV_AAIMediumConf=2",
    "NONInt_th_completeness_CheckV_AAIMediumConf=10",
    "NONInt_th_num_predictors_CheckV_HMM=2",
    "NONInt_th_completeness_CheckV_HMM=10",

    "Int_th_num_predictors_CheckV_NA=3",
    "Int_th_num_predictors_CheckV_AAIHighConf=1",
    "Int_th_completeness_CheckV_AAIHighConf=30",
    "Int_th_num_predictors_CheckV_AAIMediumConf=2",
    "Int_th_completeness_CheckV_AAIMediumConf=10",
    "Int_th_num_predictors_CheckV_HMM=2",
    "Int_th_completeness_CheckV_HMM=10"
    
    #= FINAL thresholding old
    "th_num_predictors_NonIntegrated=2", # default is 3, Integer
    "th_num_predictors_Integrated=2",  # default is 2
    #"th_num_predictors_Mixed=1",  # default is 1
    "th_checkV_completeness_NonInt=30",  # default is set to 30, Float
    "th_checkV_completeness_Int=30",
    #"th_checkV_completeness_Mixed=50",
    "th_checkV_contamination_NonInt=50",  # default is set to 30, Float
    "th_checkV_contamination_Int=10",
    #"th_checkV_contamination_Mixed=50",
    =# 

    #"num_threads=20"
] =#

#= ProjMultiWorkflow - a multiple binning workflow
args = [
    "projtype=multipleworkflow",
    "spd=/data3/CLM_projs/TEST_Workflows/DoViPv0.9",
    "allrefs_params=//data3/CLM_projs/TEST_Workflows/inDoViP/inrefs_params.tsv",
    "continue=false",
] =#
 #endregion