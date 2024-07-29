# DoViP parameters


## Arguments to be given to DoViP through the .tsv file



### General project options

#### `inref`
    * the path toward the fasta file containing the input contigs. 
    * Accepted file extensions are: ".fasta", ".fna", ".fst", ".fas", ".fa", ".mfa"
    * mandatory parameter, no default is given

#### `projtype`
    * the only acceptable value here is 'singleworkflow', and it tells DoViP that only one metagenome is analysed for this row.
    * mandatory parameter, no default is given
    
#### `sample_set`
    * the name of the sample/metagenome collection
    * mandatory parameter, no default is given

#### `use_slurm`
    * if calculations should be run on an High Performance Computing Cluster, using slurm 
    * possible values: 'true' or 'false'
    * default is 'false'

#### `continue`
    * if the calculations for this sample should be continued from a previous run of the project
    * this is useful for example when changing the desired initial predictors (see details below) or the thresholds for the final selection of the viral contigs
    * possible values: 'true' or 'false'
    * default is 'false'
        Note: if continue is set to 'false' and the project folder aldready exists, a message will appear asking to confirm or deny the deletion of the existing folder.

#### `stop_after_initial_predictors`	
    * if the calculations should stop after the initial predictions have finished (useful for example if the project should be continued later)
    * possible values: 'true' or 'false'
    * default is 'false'

#### `min_contig_length`
    * the minimum length of the contigs from the input file (inref) which should be kept
    * only contigs equal or larger than this value will be sent to the intial predictors
    * value is Integer
    * default value is 1000


### INITIAL PREDICTIONS

### geNomad options

#### `genomad_signal`
    * if genomad predictions should be considered
    * possible values:
        * 'do' - run the step. Can be always used, regardless of the signals in the previous steps
        * 'dont' - don't run the step. It can be used only if the project is new (continue = false), or, for continued projects, if there was a 'dont' or 'remove' signal in the previous step.
        * 'use'  - doesn't take into cosideration existing results. It can't be used if the project is new (continue = false). For continued projects, it can be used only after 'do', 'use' or 'ignore' in the previous step, and, if their respective "progress" is finished.
        * 'use_external' - use results calculate previously independent from a DoViP project.
        * 'ignore' - doesn't take into cosideration existing results. It can't be used if the project is new (continue = false). For continued projects, it can be used only after 'do', 'use' or 'ignore' in the previous step, and, if their respective "progress" is finished. 
        * 'remove' - removes results calculated in a previous step. It can't be used if the project is new (continue = false). For continued projects, it can be used only after 'do', 'use' or ignore in the previous step, regardless of their "progress". 
        * mandatory parameter, no default is given

#### `genomad_res`
    * the path toward the folder with geNomad results that were calculated outside DoViP
    * it will only have effect ig 'genomad_signal=use_external'
#### `genomad_env`
    * the path toward the conda environment where geNomad was installed
    * mandatory parameter, no default is given
#### `genomadDB_p`	
    * the path toward the folder with the geNomad database
    * mandatory parameter, no default is given
#### `genomad_min_score`
    * mininum score to be used by geNomad
    * value is Float
    * default it 0.7
#### `genomad_sbatch_time`
    * maximum time that a sbatch job running geNomad (in slurm) should have
    * mandatory parameter when running on HPC, no default is given
#### `genomad_cpus_per_task`
    * the maximum number of CPUs in which geNomad should be run (either on a local server or on HPC)
    * value is Integer
    * default is 20 
#### `genomad_sbatch_mem`
    * the maximum memmory requirements if geNomad is run as an sbatch job
    * mandatory parameter when running on HPC, no default is given 

### DeepVir Finder options
#### `DVF_signal`	
#### `DVF_env`	
#### `DVF_maxContigLen`	
#### `DVF_scoreTh`	
#### `DVF_pThreshold`	
#### `DVF_p`	
#### `DVF_sbatch_time`	
#### `DVF_cpus_per_task`	
#### `DVF_sbatch_mem`		

### VirSorter2 options
#### `virSorter2_signal`
#### `virSorter2_res`	
#### `virSorter2_env`	
#### `virSorter2DB_p`	
#### `virSorter2_high_confidence_only`	
#### `virSorter2_min_score`	
#### `virSorter2_sbatch_time`	
#### `virSorter2_cpus_per_task`	
#### `virSorter2_sbatch_mem`	

### VIBRANT options
#### `vibrant_signal`	
#### `vibrant_res`	
#### `vibrant_env`	
#### `vibrant_p`	
#### `vibrantDB_p`	
#### `vibrant_sbatch_time`	
#### `vibrant_cpus_per_task`	
#### `vibrant_sbatch_mem`	


### ViralVerify options
#### `viralVerify_signal`	
#### `viralVerify_res`	
#### `viralVerify_env`	
#### `viralVerifyDB_p`	
#### `viralVerify_p`	
#### `viralVerfify_threshold`	
#### `viralVerify_sbatch_time`	
#### `viralVerify_cpus_per_task`	
#### `viralVerify_sbatch_mem`	


### CheckV options
#### `checkv_env`	
#### `checkvDB_p`	
#### `checkv_sbatch_time`	
#### `checkv_cpus_per_task`	
#### `checkv_sbatch_mem`	


### PhaTYP options
#### `phaTYP_env`	
#### `phaTYP_p`	
#### `phaTYPdb_p`	
#### `phaTYPparam_p`	
#### `phaTYP_sbatch_time`	
#### `phaTYP_cpus_per_task`	
#### `phaTYP_sbatch_mem`	


### NON-INTEGRATED viruses branch: options to select final viral contigs
#### `NONInt_th_num_predictors_CheckV_NA`	
#### `NONInt_th_num_predictors_CheckV_AAIHighConf`	
#### `NONInt_th_completeness_CheckV_AAIHighConf`	
#### `NONInt_th_num_predictors_CheckV_AAIMediumConf`	
#### `NONInt_th_completeness_CheckV_AAIMediumConf`	
#### `NONInt_th_num_predictors_CheckV_HMM`	
#### `NONInt_th_completeness_CheckV_HMM`	

### INTEGRATED viruses branch: options to select final viral contigs
#### `Int_th_num_predictors_CheckV_NA`	
#### `Int_th_num_predictors_CheckV_AAIHighConf`	
#### `Int_th_completeness_CheckV_AAIHighConf`	
#### `Int_th_num_predictors_CheckV_AAIMediumConf`	
#### `Int_th_completeness_CheckV_AAIMediumConf`	
#### `Int_th_num_predictors_CheckV_HMM`	
#### `Int_th_completeness_CheckV_HMM`