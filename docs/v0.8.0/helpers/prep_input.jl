using CSV
using DataFrames

input_file_path = "/data3/CLM_projs/TEST_Workflows/inDoViP/inrefs.tsv" #"path/to/file_with_input_fasta_paths.tsv"        # this file should have only one column, named 'inref'
input_df = CSV.read(input_file_path, DataFrame; delim='\t', header=true)

# project related parameters
input_df[!, :projtype] = fill("singleworkflow", nrow(input_df))
input_df[!, :sample_set] = fill("TEST_set", nrow(input_df))
input_df[!, :use_slurm] = fill("false", nrow(input_df))
input_df[!, :continue] = fill("false", nrow(input_df))
input_df[!, :stop_after_initial_predictors] = fill("false", nrow(input_df))
input_df[!, :min_contig_length] = fill("3000", nrow(input_df))

# genomad related parameters
input_df[!, :genomad_signal] = fill("do", nrow(input_df))
input_df[!, :genomad_res] = fill("/path/to/previous/results", nrow(input_df)) 
input_df[!, :genomad_env] = fill("conda_genomad", nrow(input_df))
input_df[!, :genomadDB_p] = fill("path/to/genomad_db/genomad_db/", nrow(input_df))
input_df[!, :genomad_min_score] = fill("0.7", nrow(input_df))
input_df[!, :genomad_sbatch_time] = fill("2-0", nrow(input_df))
input_df[!, :genomad_cpus_per_task] = fill("25", nrow(input_df))
input_df[!, :genomad_sbatch_mem] = fill("20G", nrow(input_df))

# DVF related parameters
input_df[!, :DVF_signal] = fill("do", nrow(input_df))
input_df[!, :DVF_env] = fill("conda_DVF", nrow(input_df))
input_df[!, :DVF_maxContigLen] = fill("2099000", nrow(input_df))
input_df[!, :DVF_scoreTh] = fill("0.7", nrow(input_df))
input_df[!, :DVF_pThreshold] = fill("0.01", nrow(input_df))
input_df[!, :DVF_p] = fill("path/to/DeepVirFinder/dvf.py", nrow(input_df))
input_df[!, :DVF_sbatch_time] = fill("2-0", nrow(input_df))
input_df[!, :DVF_cpus_per_task] = fill("15", nrow(input_df))
input_df[!, :DVF_sbatch_mem] = fill("20G", nrow(input_df))

# virSorter2 related parameters
input_df[!, :virSorter2_signal] = fill("do", nrow(input_df))
input_df[!, :virSorter2_res] = fill("/path/to/previous/results", nrow(input_df)) 
input_df[!, :virSorter2_env] = fill("conda_virsorter2", nrow(input_df))
input_df[!, :virSorter2DB_p] = fill("path/to/virsorter-data/virsorter2/db/", nrow(input_df)) 
input_df[!, :virSorter2_high_confidence_only] = fill("false", nrow(input_df))
input_df[!, :virSorter2_min_score] = fill("0.5", nrow(input_df))
input_df[!, :virSorter2_sbatch_time] = fill("4-0", nrow(input_df))
input_df[!, :virSorter2_cpus_per_task] = fill("25", nrow(input_df))
input_df[!, :virSorter2_sbatch_mem] = fill("20G", nrow(input_df))

# VIBRANT related parameters
input_df[!, :vibrant_signal] = fill("do", nrow(input_df))
input_df[!, :vibrant_res] = fill("/path/to/previous/results", nrow(input_df)) 
input_df[!, :vibrant_env] = fill("conda_VIBRANT", nrow(input_df))
input_df[!, :vibrant_p] = fill("path/to/VIBRANT/VIBRANT_run.py", nrow(input_df))
input_df[!, :vibrantDB_p] = fill("/path/to/VIBRANT/databases/", nrow(input_df))
input_df[!, :vibrant_sbatch_time] = fill("2-0", nrow(input_df))
input_df[!, :vibrant_cpus_per_task] = fill("25", nrow(input_df))
input_df[!, :vibrant_sbatch_mem] = fill("20G", nrow(input_df))

# viralVerify related parameters
input_df[!, :viralVerify_signal] = fill("do", nrow(input_df))
input_df[!, :viralVerify_res] = fill("/path/to/previous/results", nrow(input_df)) 
input_df[!, :viralVerify_env] = fill("conda_viralVerify", nrow(input_df))
input_df[!, :viralVerifyDB_p] = fill("path/to/conda_viralVerify/DB/viralverifyDB_nbc_hmms.hmm", nrow(input_df))
input_df[!, :viralVerify_p] = fill("path/to/conda/conda_viralVerify/viralVerify/bin/viralverify", nrow(input_df))
input_df[!, :viralVerfify_threshold] = fill("7", nrow(input_df))
input_df[!, :viralVerify_sbatch_time] = fill("2-0", nrow(input_df))
input_df[!, :viralVerify_cpus_per_task] = fill("25", nrow(input_df))
input_df[!, :viralVerify_sbatch_mem] = fill("20G", nrow(input_df))

#checkV related parameters
input_df[!, :checkv_env] = fill("conda_checkV", nrow(input_df))
input_df[!, :checkvDB_p] = fill("path/to/CheckV/checkv-db-v1.5/", nrow(input_df))
input_df[!, :checkv_sbatch_time] = fill("2-0", nrow(input_df))
input_df[!, :checkv_cpus_per_task] = fill("2", nrow(input_df))
input_df[!, :checkv_sbatch_mem] = fill("20G", nrow(input_df))  

#PhaTYP related parameters
input_df[!, :phaTYP_env] = fill("conda_PhaBOX", nrow(input_df))
input_df[!, :phaTYP_p] = fill("/path/to/PhaBOX/", nrow(input_df))
input_df[!, :phaTYPdb_p] = fill("path/to/PhaBOX/database/", nrow(input_df))
input_df[!, :phaTYPparam_p] = fill("path/to/PhaBOX/parameters", nrow(input_df))
input_df[!, :phaTYP_sbatch_time] = fill("2-0", nrow(input_df))
input_df[!, :phaTYP_cpus_per_task] = fill("2", nrow(input_df))
input_df[!, :phaTYP_sbatch_mem] = fill("20G", nrow(input_df))  

# Final thresholding related parameters for NON-INTEGRATED
input_df[!, :NONInt_th_num_predictors_CheckV_NA] = fill("3", nrow(input_df))
input_df[!, :NONInt_th_num_predictors_CheckV_AAIHighConf] = fill("1", nrow(input_df))
input_df[!, :NONInt_th_completeness_CheckV_AAIHighConf] = fill("30", nrow(input_df))
input_df[!, :NONInt_th_num_predictors_CheckV_AAIMediumConf] = fill("2", nrow(input_df))
input_df[!, :NONInt_th_completeness_CheckV_AAIMediumConf] = fill("10", nrow(input_df))
input_df[!, :NONInt_th_num_predictors_CheckV_HMM] = fill("2", nrow(input_df))
input_df[!, :NONInt_th_completeness_CheckV_HMM] = fill("10", nrow(input_df))


# Final thresholding related parameters for INTEGRATED
input_df[!, :Int_th_num_predictors_CheckV_NA] = fill("3", nrow(input_df))
input_df[!, :Int_th_num_predictors_CheckV_AAIHighConf] = fill("1", nrow(input_df))
input_df[!, :Int_th_completeness_CheckV_AAIHighConf] = fill("30", nrow(input_df))
input_df[!, :Int_th_num_predictors_CheckV_AAIMediumConf] = fill("2", nrow(input_df))
input_df[!, :Int_th_completeness_CheckV_AAIMediumConf] = fill("10", nrow(input_df))
input_df[!, :Int_th_num_predictors_CheckV_HMM] = fill("2", nrow(input_df))
input_df[!, :Int_th_completeness_CheckV_HMM] = fill("10", nrow(input_df))


out_p = "/data3/CLM_projs/TEST_Workflows/inDoViP/inrefs_params_test.tsv"#"path/to/output_inrefs_params.tsv"
CSV.write(out_p, input_df, delim='\t', header=true)


