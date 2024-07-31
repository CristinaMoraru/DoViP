# DoViP singleworklow parameters 

## General project options

#### `pd_prefix`
  * this is the path toward the folder where the outputs will be saved. The outputs from each individual sample will be grouped into subfolders in this folder. In the case of the `singleworkflow` mode, only one subfolder (for one sample) will be saved. In the case of the `multiworklow` mode, several subfolders will be saved, each corresponding to one sample. The subfolders will have the same names as their corresponding input fasta files (minus the file extension). This is the single parameter that should NOT be given in the .tsv file with parameters for the multiworkflow mode.     

#### `inref`
  * the path toward the fasta file containing the input contigs. 
  * Accepted file extensions are: ".fasta", ".fna", ".fst", ".fas", ".fa", ".mfa"
  * mandatory parameter, no default is given

#### `projtype`
  * the only acceptable value here is 'singleworkflow', and it tells DoViP that only one metagenome is analyzed in this run (or for this row, when ussing a .tsv file to send the arguments to DoViP)
  * mandatory parameter, no default is given
    
#### `sample_set`
  * the name of the sample/metagenome collection
  * mandatory parameter, no default is given

#### `use_slurm`
  * if calculations should be run on an High Performance Computing Cluster, using slurm and sbatch
  * possible values: 'true' or 'false'
  * default is 'false'

#### `continue`
  * if the calculations for this sample should be continued from a previous run of the project
  * this is useful for example when changing the desired initial predictors (see details below) or the thresholds for the final selection of the viral contigs
  * possible values: 'true' or 'false'
  * default is 'false'
!!! note 
    if continue is set to 'false' and the sample subfolder already exists, a message will appear asking to confirm or deny the deletion of the existing folder.

#### `stop_after_initial_predictors`    
  * if the calculations should stop after the initial predictions have finished (useful for example if the project should be continued later)
  * possible values: 'true' or 'false'
  * default is 'false'

#### `min_contig_length`
  * the minimum length of the contigs from the input file (inref) which should be kept
  * only contigs equal or larger than this value will be sent to the initial predictors
  * value is Integer
  * default value is 1000

## PARAMETERS FOR INITIAL PREDICTION STEPS

### geNomad options
If this this step is selected for running (`genomad_signal=do`), the following will happen:  
  * DoViP will start a geNomad run in the conda environment given by the `genomad_env` parameter, using the following command:
    ```
    `genomad end-to-end --cleanup --splits 8 '/path/to/input.fasta' '/path/to/output_folder' `genomadDB_p` --min-score `genomad_min_score``
    ```
  * DoViP will postprocess the geNomad results (file `_virus_summary.tsv`) to separate NON-INTEGRATED from INTEGRATED viruses.

If, instead of running geNomad, external results should be used, the following will happen:
  * DoViP will postprocess the geNomad results (file `_virus_summary.tsv`) to separate NON-INTEGRATED from INTEGRATED viruses.

#### `genomad_signal`
  * if geNomad predictions should be considered

  * possible values:
    * 'do' - run this predictor step. Can be always used, regardless of the signals in the previous steps
    * 'dont' - don't run this predictor step. It can be used only if the project is new (continue = false), or, for continued projects, if there was a 'dont' or 'remove' signal in the previous step.
    * 'use'- re-use predictor results calculated in previous runs of this project. It can't be used if the project is new (continue = false). For continued projects, it can be used only after 'do', 'use' or 'ignore' in the previous step, and, if their respective "progress" is finished.
    * 'use_external' - use results calculated previously by the predictor independently from a DoViP project.
    * 'ignore' - doesn't take into consideration existing results calculated in a previous run of this project. It can't be used if the project is new (continue = false). For continued projects, it can be used only after 'do', 'use' or 'ignore' in the previous step, and, if their respective "progress" is finished. 
    * 'remove' - removes results calculated in a previous step. It can't be used if the project is new (continue = false). For continued projects, it can be used only after 'do', 'use' or ignore in the previous step, regardless of their "progress". 

  * mandatory parameter, no default is given

#### `genomad_res`
  * the path toward the folder with geNomad results that were calculated outside DoViP
  * needed only if `genomad_signal=use_external`
#### `genomad_env`
  * the path toward the conda environment where geNomad is installed
  * mandatory parameter if geNomad signal is `do`, no default is given
#### `genomadDB_p`  
  * the path toward the folder with the geNomad database
  * mandatory parameter if geNomad signal is `do`, no default is given
#### `genomad_min_score`
  * mininum score to be used by geNomad to filter viral contigs
  * value is Float (between 0.0 and 1.0)
  * default it 0.7
#### `genomad_sbatch_time`
  * maximum time that a sbatch job running geNomad (in slurm) is allowed to run
  * this parameter will be further transmitted to sbatch
  * mandatory parameter when running on HPC, no default is given
#### `genomad_cpus_per_task`
  * the maximum number of CPUs in which geNomad should be run (either on a local server or on HPC).
  * when running on an HPC, this parameter will be further transmitted to sbatch
  * value is Integer
  * default is 20 
#### `genomad_sbatch_mem`
  * the maximum memory requirements if geNomad is run as an sbatch job
  * this parameter will be further transmitted to sbatch
  * mandatory parameter when running on HPC, no default is given 

### DeepVir Finder options  
If this this step is selected for running (`DVF_signal=do`), the following will happen:   
  * DoViP will check each contig in the input file, and, if larger than the value of `DVF_maxContigLen` it will cut it in smaller pieces. This is to avoid DVF freezing when it encounters larger than 2099000.
  * DoViP will start a DVF run in the conda environment given by parameter `DVF_env` with the following command:  
    ```
    python 'path/to/dvf.py' -i 'path/to/input.fasta' -o' path/to/output/folder' -l 'min_contig_len' -c `DVF_cpus_per_task`
    ```
  * DoViP will merge back into a single entry the larger contigs which have been split in the first step, with the score and the p-value repersentig the median of the smaller contigs.
  * DoViP will postprocess all DVF results to remove all contigs with a score smaller than `DVF_scoreTh` and a p-value larger than `DVF_pThreshold`. Only NON-INTEGRATED viruses are outputted by DVF.

#### `DVF_signal`   
  * if DeepVir Finder predictions should be considered

  * possible values:
    * 'do' - run this predictor step. Can be always used, regardless of the signals in the previous steps
    * 'dont' - don't run this predictor step. It can be used only if the project is new (continue = false), or, for continued projects, if there was a 'dont' or 'remove' signal in the previous step.
    * 'use'- re-use predictor results calculated in previous runs of this project. It can't be used if the project is new (continue = false). For continued projects, it can be used only after 'do', 'use' or 'ignore' in the previous step, and, if their respective "progress" is finished.
    * 'use_external' - use results calculated previously by the predictor independently from a DoViP project.
    * 'ignore' - doesn't take into consideration existing results calculated in a previous run of this project. It can't be used if the project is new (continue = false). For continued projects, it can be used only after 'do', 'use' or 'ignore' in the previous step, and, if their respective "progress" is finished. 
    * 'remove' - removes results calculated in a previous step. It can't be used if the project is new (continue = false). For continued projects, it can be used only after 'do', 'use' or ignore in the previous step, regardless of their "progress". 

  * mandatory parameter if DVF should be run, no default is given

#### `DVF_env`
  * the path toward the conda environment where DVF is installed
  * mandatory parameter, no default is given    
#### `DVF_maxContigLen` 
  * the maximum length that a contig should have for DVF. If larger than this value, it will be cut into smaller pieces before being inputted into DVF.
  * value is Integer
  * default is 2099000
#### `DVF_scoreTh`
  * minimum score value calculated by DVF so that contigs are kept by DoViP 
  * value is Float (between 0 and 1)
  * default is 0.7
#### `DVF_pThreshold`   
  * the maximum p-value calculated by DVF so that contigs are kept by DoViP 
  * value is Float (between 0 and 1)
  * default is 0.01
#### `DVF_p`
  * path/to/dvf.py  
  * mandatory parameter if DVF should be run, no default is given   
#### `DVF_sbatch_time`  
  * maximum time that a sbatch job running geNomad (in slurm) is allowed to run
  * this parameter will be further transmitted to sbatch
  * mandatory parameter when running on HPC, no default is given
#### `DVF_cpus_per_task`    
  * the maximum number of CPUs in which DVF should be run (either on a local server or on HPC)
  * when running on an HPC, this parameter will be further transmitted to sbatch
  * value is Integer
  * default is 15 
#### `DVF_sbatch_mem`
  * the maximum memmory requirements if DVF is run as an sbatch job
  * this parameter will be further transmitted to sbatch
  * mandatory parameter when running on HPC, no default is given        

### VirSorter2 options
If this this step is selected for running (`virSorter2_signal=do`), the following will happen:  
  * DoViP will start a VirSorter2 run in the conda environment given by the `virSorter2_env` parameter, using the following command:
    ```
    virsorter run -i '/path/to/input.fasta' -w 'path/to/output/folder' -j `virSorter2_cpus_per_task` -d `virSorter2DB_p` --min-length `min_contig_length` --min-score `virSorter2_min_score` --tmpdir 'path/to/output/folder/tmp' --viral-gene-required --exclude-lt2gene --hallmark-required-on-short$(hc) --include-groups dsDNAphage,NCLDV,RNA,ssDNA,lavidaviridae --keep-original-seq --rm-tmpdir

    # the value of $(hc) in the code above is " --high-confidence-only" if the DoViP parameter `virSorter2_high_confidence_only=true` or "" if `virSorter2_high_confidence_only=false`
    ```
  * DoViP will postprocess the VirSorter2 results (`final-viral-score.tsv` and `final-viral-boundary.tsv` files) to separate NON-INTEGRATED from INTEGRATED viruses.

#### `virSorter2_signal`
  * if VirSorter2 predictions should be considered

  * possible values:
    * 'do' - run this predictor step. Can be always used, regardless of the signals in the previous steps
    * 'dont' - don't run this predictor step. It can be used only if the project is new (continue = false), or, for continued projects, if there was a 'dont' or 'remove' signal in the previous step.
    * 'use'- re-use predictor results calculated in previous runs of this project. It can't be used if the project is new (continue = false). For continued projects, it can be used only after 'do', 'use' or 'ignore' in the previous step, and, if their respective "progress" is finished.
    * 'use_external' - use results calculated previously by the predictor independently from a DoViP project.
    * 'ignore' - doesn't take into consideration existing results calculated in a previous run of this project. It can't be used if the project is new (continue = false). For continued projects, it can be used only after 'do', 'use' or 'ignore' in the previous step, and, if their respective "progress" is finished. 
    * 'remove' - removes results calculated in a previous step. It can't be used if the project is new (continue = false). For continued projects, it can be used only after 'do', 'use' or ignore in the previous step, regardless of their "progress". 

  * mandatory parameter, no default is given

#### `virSorter2_res`   
  * the path toward the folder with VirSorter2 results that were calculated outside DoViP
  * needed only if `virSorter2_signal=use_external`
#### `virSorter2_env`   
  * the path toward the conda environment where VirSorter2 is installed
  * mandatory parameter if virSorter2 signal is `do`, no default is given, no default is given
#### `virSorter2DB_p`
  * the path toward the folder with the virSorter2 database
  * mandatory parameter if virSorter2 signal is `do`, no default is given, no default is given  
#### `virSorter2_high_confidence_only`
  * will tell VirSorter2 if it should keep only the high confidence contigs
  * possible values: 'true' or 'false'
  * default is 'false'
#### `virSorter2_min_score` 
  * minimum score to be used by VirSorter2 to filter viral contigs
  * value is Float (between 0.0 and 1.0)
  * default it 0.5
#### `virSorter2_sbatch_time`   
  * maximum time that a sbatch job running VirSorter2 (in slurm) is allowed to run
  * this parameter will be further transmitted to sbatch
  * mandatory parameter when running on HPC, no default is given
#### `virSorter2_cpus_per_task` 
  * the maximum number of CPUs in which VirSorter2 should be run (either on a local server or on HPC)
  * when running on an HPC, this parameter will be further transmited to sbatch
  * value is Integer
  * default is 20 
#### `virSorter2_sbatch_mem`    
  * the maximum memory requirements if VirSorter2 is run as an sbatch job
  * this parameter will be further transmitted to sbatch
  * mandatory parameter when running on HPC, no default is given 

### VIBRANT options
If this this step is selected for running (`vibrant_signal=do`), the following will happen:  
  * DoViP will start a VIBRANT run in the conda environment given by the `vibrant_env` parameter, using the following command:
    ```
    python3 `vibrant_p` -f nucl -i '/path/to/input.fasta' -folder 'path/to/output/folder' -t `vibrant_cpus_per_task` -d `vibrantDB_p` -l `min_contig_length`
    ```
  * DoViP will postprocess the VIBRANT outputs (`VIBRANT_integrated_prophage_coordinates_$(sampleName).tsv`, `$(sampleName).phages_lytic.fna`) to separate NON-INTEGRATED from INTEGRATED viruses.

#### `vibrant_signal`   
  * if VIBRANT predictions should be considered

  * possible values:

    * 'do' - run this predictor step. Can be always used, regardless of the signals in the previous steps
    * 'dont' - don't run this predictor step. It can be used only if the project is new (continue = false), or, for continued projects, if there was a 'dont' or 'remove' signal in the previous step.
    * 'use'- re-use predictor results calculated in previous runs of this project. It can't be used if the project is new (continue = false). For continued projects, it can be used only after 'do', 'use' or 'ignore' in the previous step, and, if their respective "progress" is finished.
    * 'use_external' - use results calculated previously by the predictor independently from a DoViP project.
    * 'ignore' - doesn't take into consideration existing results calculated in a previous run of this project. It can't be used if the project is new (continue = false). For continued projects, it can be used only after 'do', 'use' or 'ignore' in the previous step, and, if their respective "progress" is finished. 
    * 'remove' - removes results calculated in a previous step. It can't be used if the project is new (continue = false). For continued projects, it can be used only after 'do', 'use' or ignore in the previous step, regardless of their "progress". 

  * mandatory parameter, no default is given

#### `vibrant_res`  
  * the path toward the folder with VIBRANT results that were calculated outside DoViP
  * needed only if `vibrant_signal=use_external`
#### `vibrant_env`  
  * the path toward the conda environment where VIBRANT is installed
  * mandatory parameter if VIBRANT signal is `do`, no default is given, no default is given
#### `vibrant_p`
  * path/to/VIBRANT_run.py  
  * mandatory parameter if VIBRANT signal is `do`, no default is given, no default is given
#### `vibrantDB_p`
  * the path toward the folder with the VIBRANT database
  * mandatory parameter if VIBRANT signal is `do`, no default is given, no default is given 
#### `vibrant_sbatch_time`  
  * maximum time that a sbatch job running VIBRANT (in slurm) is allowed to run
  * this parameter will be further transmitted to sbatch
  * mandatory parameter when running on HPC and VIBRANT signal is `do`, no default is given 
#### `vibrant_cpus_per_task`    
  * the maximum number of CPUs in which VIBRANT should be run (either on a local server or on HPC)
  * when running on an HPC, this parameter will be further transmitted to sbatch
  * value is Integer
  * default is 20 
#### `vibrant_sbatch_mem`   
  * the maximum memmory requirements if VIBRANT is run as an sbatch job
  * this parameter will be further transmitted to sbatch
  * mandatory parameter when running on HPC and VIBRANT signal is `do`, no default is given 

### ViralVerify options
If this this step is selected for running (`viralVerify_signal=do`), the following will happen:  
  * DoViP will start a ViralVerify run in the conda environment given by the `viralVerify_env` parameter, using the following command:
    ```
    viralVerify_p` -f '/path/to/input.fasta' -o 'path/to/output/folder' --hmm `viralVerifyDB_p` --thr `viralVerfify_threshold` -t `viralVerify_cpus_per_task` -p
    ```
  * DoViP will postprocess ViralVerify outputs (`_result_table.csv`) to select only the viral contigs with a score bigger than `viralVerfify_threshold`.  Only NON-INTEGRATED viruses are outputted by ViralVerify.

#### `viralVerify_signal`   
  * if ViralVerify predictions should be considered

  * possible values:

    * 'do' - run this predictor step. Can be always used, regardless of the signals in the previous steps
    * 'dont' - don't run this predictor step. It can be used only if the project is new (continue = false), or, for continued projects, if there was a 'dont' or 'remove' signal in the previous step.
    * 'use'- re-use predictor results calculated in previous runs of this project. It can't be used if the project is new (continue = false). For continued projects, it can be used only after 'do', 'use' or 'ignore' in the previous step, and, if their respective "progress" is finished.
    * 'use_external' - use results calculated previously by the predictor independently from a DoViP project.
    * 'ignore' - doesn't take into consideration existing results calculated in a previous run of this project. It can't be used if the project is new (continue = false). For continued projects, it can be used only after 'do', 'use' or 'ignore' in the previous step, and, if their respective "progress" is finished. 
    * 'remove' - removes results calculated in a previous step. It can't be used if the project is new (continue = false). For continued projects, it can be used only after 'do', 'use' or ignore in the previous step, regardless of their "progress". 

  * mandatory parameter, no default is given
#### `viralVerify_res`  
  * the path toward the folder with ViralVerify results that were calculated outside DoViP
  * needed only if `viralVerify_signal=use_external`
#### `viralVerify_env`  
  * the path toward the conda environment where ViralVerify is installed
  * mandatory parameter if ViralVerify signal is `do`, no default is given, no default is given
#### `viralVerifyDB_p`  
  * the path toward the HMM profile file of the ViralVerify database
  * mandatory parameter if ViralVerify signal is `do`, no default is given, no default is given
#### `viralVerify_p`
  * path/to/bin/viralverify 
  * mandatory parameter if ViralVerify signal is `do`, no default is given, no default is given
#### `viralVerfify_threshold`   
  * score used to select viral contigs outputted by ViralVerify. 
  * value is Integer (between 1 and 1000)
  * default is 7
#### `viralVerify_sbatch_time`  
  * maximum time that a sbatch job running ViralVeriffy (in slurm) is allowed to run
  * mandatory parameter when running on HPC and ViralVerify signal is `do`, no default is given
#### `viralVerify_cpus_per_task`    
  * the maximum number of CPUs in which ViralVerify should be run (either on a local server or on HPC)
  * value is Integer
  * default is 20 
#### `viralVerify_sbatch_mem`   
  * the maximum memmory requirements if ViralVerify is run as an sbatch job
  * this parameter will be further transmitted to sbatch
  * mandatory parameter when running on HPC and ViralVerify signal is `do`, no default is given 

## PARAMETERS FOR CONSENSUS PREDICTION STEPS
### CheckV options
CheckV is used both on the NON-INTEGRATED and INTEGRATED viruses branch to detect viral contigs with host contamination (if they are on the NON-INTEGRATED branch they will be moved to the INTEGRATED branch) and remove the host regions.  
In all cases, CheckV is run with the following command:  
```
checkv end_to_end 'path/to/input.fasta' 'path/to/output_folder' -t `checkv_cpus_per_task` -d `checkvDB_p` --remove_tmp
```
The CheckV statistics will be incorporated in the final virus contig tables.

#### `checkv_env`   
  * the path toward the conda environment where CheckV is installed
  * mandatory parameter, no default is given
#### `checkvDB_p`   
  * the path toward the folder with the CheckV database
  * mandatory parameter, no default is given
#### `checkv_sbatch_time`   
  * maximum time that a sbatch job running CheckV (in slurm) is allowed to run
  * this parameter will be further transmitted to sbatch
  * mandatory parameter when running on HPC, no default is given
#### `checkv_cpus_per_task` 
  * the maximum number of CPUs in which CheckV should be run (either on a local server or on HPC)
  * when running on an HPC, this parameter will be further transmitted to sbatch
  * value is Integer
  * default is 2 
#### `checkv_sbatch_mem`    
  * the maximum memmory requirements if checkV is run as an sbatch job
  * this parameter will be further transmitted to sbatch
  * mandatory parameter when running on HPC, no default is given 

### PhaTYP options
PhaTYP is used on the NON-INTEGRATED viruses branch to predict the potential lifestyle of the respective viruses.  
PhaTYP is run with the following command:
```
python `phaTYP_p/PhaTYP_single.py` --contigs 'path/to/input.fasta' --threads `phaTYP_cpus_per_task` --len `min_contig_length` --rootpth 'path/to/temp_output_folder' --out 'path/to/output_folder' --dbdir `phaTYPdb_p` --parampth `phaTYPparam_p`
```
The PhaTYP predictions will be incorporated in the final virus contig tables.
#### `phaTYP_env`   
  * the path toward the conda environment where PhaTYP is installed
  * mandatory parameter, no default is given
#### `phaTYP_p` 
  * the path toward the folder with PhaTYP
  * mandatory parameter, no default is given
#### `phaTYPdb_p`   
  * the path toward the folder with the PhaTYP database
  * mandatory parameter, no default is given
#### `phaTYPparam_p`    
  * the path toward the folder with the PhaTYP parameters (see PhaTYP manual)
  * mandatory parameter, no default is given
#### `phaTYP_sbatch_time`   
  * maximum time that a sbatch job running PhaTYP (in slurm) is allowed to run
  * this parameter will be further transmited to sbatch
  * mandatory parameter when running on HPC, no default is given
#### `phaTYP_cpus_per_task` 
  * the maximum number of CPUs in which PhaTYP should be run (either on a local server or on HPC)
  * when running on an HPC, this parameter will be further transmitted to sbatch
  * value is Integer
  * default is 2 
#### `phaTYP_sbatch_mem`    
  * the maximum memory requirements if PhaTYP is run as an sbatch job
  * this parameter will be further transmitted to sbatch
  * mandatory parameter when running on HPC, no default is given 

## NON-INTEGRATED viruses branch: options to select final viral contigs
At the end of the workflow DoViP keeps only the NON-INTEGRATED viral contigs that fulfill certain criteria. The selection depends on the method used by CheckV to estimate the viral contig completeness, on the value of the viral contig completeness, and on the number of initial predictors that outputted the respective viral contig. 

### If CheckV could not estimate the completeness of the viral contigs:
  * it means that CheckV could not find similarities in its database
  * than only the number of viral predictors is taken into consideration. 
  * I recommend using a higher number of initial predictors, to increase the confidence that the respective contig is actually viral  
#### `NONInt_th_num_predictors_CheckV_NA`   
  * this parameters gives the minimum number of initial predictors necessary to keep a viral contig if completeness is NA
  * value is Integer
  * default is 3

### If CheckV used AAIHighConf method to estimate the completeness of the viral contigs:
  * it means that it found related viruses in its database and it can estimate the completeness with high precision
  * all viral contigs with a completeness of at least 90% are kept, regardless of the number of initial predictors 
#### `NONInt_th_num_predictors_CheckV_AAIHighConf`
  * this parameter gives the minimum number of initial predictors necessary to keep a viral contig if the method for determining the completeness is AAIHighConf
  * value is Integer
  * default is 1
#### `NONInt_th_completeness_CheckV_AAIHighConf`
  * this parameter gives the minimum completeness to keep a viral contig when the method for determining the completeness is AAIHighConf
  * value is Float
  * default is 30.0

### If CheckV used AAIMediumConf method to estimate the completeness of the viral contigs:
  * it means that it found related viruses in its database and it can estimate the completeness with moderate precission
#### `NONInt_th_num_predictors_CheckV_AAIMediumConf`
  * this parameter gives the minimum number of initial predictors necessary to keep a viral contig if the method for determining the completeness is AAIMediumConf
  * value is Integer
  * default is 2    
#### `NONInt_th_completeness_CheckV_AAIMediumConf`  
  * this parameter gives the minimum completeness to keep a viral contig when the method for determining the completeness is AAIMediumConf
  * value is Float
  * default is 10.0

### If CheckV used HMM method to estimate the completeness of the viral contigs:
  * it means that it found distantly related viruses in its database and it can estimate the completeness with low precision
#### `NONInt_th_num_predictors_CheckV_HMM`  
  * this parameter gives the minimum number of initial predictors necessary to keep a viral contig if the method for determining the completeness is HMM
  * value is Integer
  * default is 2    
#### `NONInt_th_completeness_CheckV_HMM`    
  * this parameter gives the minimum completeness to keep a viral contig when the method for determining the completeness is HMM
  * value is Float
  * default is 10.0

## INTEGRATED viruses branch: options to select final viral contigs
At the end of the workflow DoViP keeps only the INTEGRATED viruses that fulfill certain criteria. The selection depends on the method used by CheckV to estimate the viral contig completeness, on the value of the viral contig completeness, and on the number of initial predictors that outputted the respective viral contig.   

### If CheckV could not estimate the completeness of the viral contigs:
  * it means that CheckV could not find similarities in its database
  * than only the number of viral predictors is taken into consideration. 
  * I recommend using a higher number of initial predictors, to increase the confidence that the respective contig is actually viral  
#### `Int_th_num_predictors_CheckV_NA`  
  * this parameter gives the minimum number of initial predictors necessary to keep a viral contig if completeness is NA
  * value is Integer
  * default is 3

### If CheckV used AAIHighConf method to estimate the completeness of the viral contigs:
  * it means that it found related viruses in its database and it can estimate the completeness with high precision
  * all viral contigs with a completeness of at least 90% are kept, regardless of the number of initial predictors 
#### `Int_th_num_predictors_CheckV_AAIHighConf` 
  * this parameter gives the minimum number of initial predictors necessary to keep a viral contig if the method for determining the completeness is AAIHighConf
  * value is Integer
  * default is 1
#### `Int_th_completeness_CheckV_AAIHighConf`
  * this parameter gives the minimum completeness to keep a viral contig when the method for determining the completeness is AAIHighConf
  * value is Float
  * default is 30.0

### If CheckV used AAIMediumConf method to estimate the completeness of the viral contigs:
  * it means that it found related viruses in its database and it can estimate the completeness with moderate precission
#### `Int_th_num_predictors_CheckV_AAIMediumConf`   
  * this parameter gives the minimum number of initial predictors necessary to keep a viral contig if the method for determining the completeness is AAIMediumConf
  * value is Integer
  * default is 2    
#### `Int_th_completeness_CheckV_AAIMediumConf` 
  * this parameter gives the minimum completeness to keep a viral contig when the method for determining the completeness is AAIMediumConf
  * value is Float
  * default is 10.0

### If CheckV used HMM method to estimate the completeness of the viral contigs:
  * it means that it found distantly related viruses in its database and it can estimate the completeness with low precision
#### `Int_th_num_predictors_CheckV_HMM`
  * this parameter gives the minimum number of initial predictors necessary to keep a viral contig if the method for determining the completeness is HMM
  * value is Integer
  * default is 2        
#### `Int_th_completeness_CheckV_HMM`
  * this parameter gives the minimum completeness to keep a viral contig when the method for determining the completeness is HMM
  * value is Float
  * default is 10.0

