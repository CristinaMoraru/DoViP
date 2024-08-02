library(tidyverse)

# Define the path to the input TSV file containing FASTA paths
input_file_path <- "~/SCIENCE/PROJECTS/+test/DoViP/inrefs.tsv"  # This file should have only one column, named 'inref'

# Read the TSV file into a tibble
input_df <- read.csv(file = input_file_path, header = TRUE, sep = "\t", stringsAsFactors = FALSE)

# Project-related parameters
input_df <- input_df %>%
  mutate(
    projtype = "singleworkflow",
    sample_set = "TEST_set",
    use_slurm = "false",
    continue = "false",
    stop_after_initial_predictors = "false",
    min_contig_length = "3000"
  )

# Genomad-related parameters
input_df <- input_df %>%
  mutate(
    genomad_signal = "do",
    genomad_res = "/path/to/previous/results",
    genomad_env = "conda_genomad",
    genomadDB_p = "path/to/genomad_db/genomad_db/",
    genomad_min_score = "0.7",
    genomad_sbatch_time = "2-0",
    genomad_cpus_per_task = "25",
    genomad_sbatch_mem = "20G"
  )

# DeepVirFinder-related parameters
input_df <- input_df %>%
  mutate(
    DVF_signal = "do",
    DVF_env = "conda_DVF",
    DVF_maxContigLen = "2099000",
    DVF_scoreTh = "0.7",
    DVF_pThreshold = "0.01",
    DVF_p = "path/to/DeepVirFinder/dvf.py",
    DVF_sbatch_time = "2-0",
    DVF_cpus_per_task = "15",
    DVF_sbatch_mem = "20G"
  )

# VirSorter2-related parameters
input_df <- input_df %>%
  mutate(
    virSorter2_signal = "do",
    virSorter2_res = "/path/to/previous/results",
    virSorter2_env = "conda_virsorter2",
    virSorter2DB_p = "path/to/virsorter-data/virsorter2/db/",
    virSorter2_high_confidence_only = "false",
    virSorter2_min_score = "0.5",
    virSorter2_sbatch_time = "4-0",
    virSorter2_cpus_per_task = "25",
    virSorter2_sbatch_mem = "20G"
  )

# VIBRANT-related parameters
input_df <- input_df %>%
  mutate(
    vibrant_signal = "do",
    vibrant_res = "/path/to/previous/results",
    vibrant_env = "conda_VIBRANT",
    vibrant_p = "path/to/VIBRANT/VIBRANT_run.py",
    vibrantDB_p = "/path/to/VIBRANT/databases/",
    vibrant_sbatch_time = "2-0",
    vibrant_cpus_per_task = "25",
    vibrant_sbatch_mem = "20G"
  )

# ViralVerify-related parameters
input_df <- input_df %>%
  mutate(
  viralVerify_signal ="do",
  viralVerify_res ="/path/to/previous/results",
  viralVerify_env ="conda_viralVerify",
  viralVerifyDB_p ="path/to/conda_viralVerify/DB/viralverifyDB_nbc_hmms.hmm",
  viralVerify_p ="path/to/conda/conda_viralVerify/viralVerify/bin/viralverify",
  viralVerfify_threshold ="7",
  viralVerify_sbatch_time ="2-0",
  viralVerify_cpus_per_task ="25",
  viralVerify_sbatch_mem ="20G"
  )
  
# CheckV-related parameters
input_df <- input_df %>%
  mutate(
  checkv_env ="conda_checkV",
  checkvDB_p ="path/to/CheckV/checkv-db-v1.5/",
  checkv_sbatch_time ="2-0",
  checkv_cpus_per_task ="2",
  checkv_sbatch_mem ="20G"
  )

# PhaTYP-related parameters
input_df <- input_df %>%
  mutate(
  phaTYP_env ="conda_PhaBOX",
  phaTYP_p ="/path/to/PhaBOX/",
  phaTYPdb_p ="path/to/PhaBOX/database/",
  phaTYPparam_p ="path/to/PhaBOX/parameters",
  phaTYP_sbatch_time ="2-0",
  phaTYP_cpus_per_task ="2",
  phaTYP_sbatch_mem ="20G"
  )

# NON-INTEGRATED viruses - final selection parameters
input_df <- input_df %>%
  mutate(
  NONInt_th_num_predictors_CheckV_NA ="3",
  NONInt_th_num_predictors_CheckV_AAIHighConf ="1",
  NONInt_th_completeness_CheckV_AAIHighConf ="30",
  NONInt_th_num_predictors_CheckV_AAIMediumConf ="2",
  NONInt_th_completeness_CheckV_AAIMediumConf ="10",
  NONInt_th_num_predictors_CheckV_HMM ="2",
  NONInt_th_completeness_CheckV_HMM ="10"
  )

# INTEGRATED viruses - final selection parameters
input_df <- input_df %>%
  mutate(  
  Int_th_num_predictors_CheckV_NA ="3",
  Int_th_num_predictors_CheckV_AAIHighConf ="1",
  Int_th_completeness_CheckV_AAIHighConf ="30",
  Int_th_num_predictors_CheckV_AAIMediumConf ="2",
  Int_th_completeness_CheckV_AAIMediumConf ="10",
  Int_th_num_predictors_CheckV_HMM ="2",
  Int_th_completeness_CheckV_HMM ="10"
)

# Write the data frame to a TSV file
out_p <- "~/SCIENCE/PROJECTS/+test/DoViP/output_inrefs_params.tsv"
write_tsv(input_df, out_p)