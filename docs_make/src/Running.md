# Running DoViP - overview

DoViP can be run in a single sample mode (`projtype=singleworkflow`) or in a multiple sample mode (`projtype=multiworkflow`). In singleworkflow mode it processes only one sample (one input fasta file, representing a metagenome for example). There are many parameters required for the singleworkflow mode (see next page) and they should all be given as arguments from the command line. In multiworkflow mode DoViP processes multiple samples (multiple input fasta files) one after the other, each with its own individual parameters (the same parameters as for singleworkflow mode, but without `pd_prefix`). These parameters should be given to DoViP as a .tsv table, where one row represents one sample. 


## Modalities to call DoViP

After activating the corresponding conda environment, DoViP can be started simply by its name. This calls a bash function which starts the Julia programming language and the DoViP_App.jl module.  
    ```
    conda activate conda_DoViP

    DoViP [...args]
    ```

Alternatively, the DoViP_App module can be called directly, as exemplified below.  
    ```
    julia path/to/conda_DoViP/DoViP_App.jl/src/DoViP_App.jl [...args]
    ```
Calling directly the DoViP_App.jl module is required when using tools like `nice` (to set process priorities) and `taskset` (to confine the processes only to a selected CPUs subset).  
    ```
    nice -n 10 taskset -c 76-90 julia path/to/conda_DoViP/DoViP_App.jl/src/DoViP_App.jl [...args]
    ```
    
The parameters used by DoViP for each sample are saved in its corresponding subfolder in the file `project_parameters_and_status.txt`. Besides the parameters, in this file it is also saved a brief status report showing which individual steps should be run, have been finished or are curently running. However, the complete log for each DoViP step is sent to the standard output. To save it and potential errors to a file, use the code below:
    ```
    nice -n 10 taskset -c 76-90 julia path/to/conda_DoViP/DoViP_App.jl/src/DoViP_App.jl [...args] > dovip_sample.log 2> dovip_sample.err 
    ```
!!! note
    If the project folder or individual sample subfolders already exist, for example from a previous DoViP run, and the DoViP is started with the parameter `continue=false`, the user will be asked at the standard output if the existent folders should be overwriten or not. This message will not be visible if the standard output is sent to a file.
