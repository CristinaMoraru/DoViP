# Continuing projects

## Singleworkflow projects
When running in `singleworkflow` mode, DoViP records the progress through the workflow steps and other various parameters. This information is saved in binary files ([`sproj.binary`](dovip_projects.md#singleworkflow-projects)), which can later be used to resume the calculations for a project. 
There are several reasons to continue an already finished project:
  * to add/remove results from any of the five initial predictors. For details, see the description of the [`genomad_signal`](Running_singleworkflow_params.md#genomad_signal), [`DVF_signal`](Running_singleworkflow_params.md#DVF_signal), [`virSorter2_signal`](Running_singleworkflow_params.md#virSorter2_signal), [`vibrant_signal`](Running_singleworkflow_params.md#vibrant_signal) and [`viralVerify_signal`](Running_singleworkflow_params.md#viralVerify_signal) arguments.
  * to continue calculations past the initial predictors step. For details, see the [`stop_after_initial_predictors`](Running_singleworkflow_params.md#stop_after_initial_predictors) argument.
  * to change the parameters for the final selection of the contigs
  * to resume a failed project (e.g., a project which failed in the VIBRANT step because the name of the conda environment was not correctly setup, can be continued without having to recalculate the first three predictors)

To continue `singleworkflow` projects, the [`continue`](Running_singleworkflow_params.md#continue) argument needs to be setup to `true`. In this case, some of the DoViP ouptuts could be deleted and recalculated, as follows:
  * when adding/removing results from any of the initial predictors, all the outputs from the Consensus Prediction Step and the Final Thresholding Step will be removed
  * when changing the parameters for the final selection of the contigs, the previous outputs will be first removed and then re-calculated

## Multipleworkflow projects
When running in `multipleworkflow` mode, DoViP records the progress in processing each of the samples ("done", "running", "not_done") in another binary file ([`mproj.binary`](dovip_projects.md#multipleworkflow-projects)). Furthermore, since each sample subfolder is the equivalent of a `singleworkflow` project, it also records the progress of the workflow within individual samples in the corresponding [`sproj.binary` file](dovip_projects.md#singleworkflow-projects). Later on, DoViP can use the information stored in these files to continue the project.
As a result, in the context of `multipleworkflow` projects, the `continue` argument has two meanings:
  * first, when used as a DoViP argument at the command line in conjuction with `projtype=multipleworkflow`, it means if generally the multipleworkflow project should be continued or not
  * second, when used in the .tsv file given as value to the [`allrefs_params`](Running_multipleworkflow_params.md#allrefs_params) argument, it indicates if a particular sample from the .tsv file should be continued or not
Taken togheter, it means that, when continuing a `multipleworkflow` project, DoViP will:
  * check the `continue` argument for each sample. 
    + If it's value is `false`, it will check further if the status of the sample is "done", "running" or "not_done". If "done", it will move to the next sample. If not, it will perform the calculations for this sample.
    + If it's value is `true`, it will redo the calculations for this sample, using the parameters in the .tsv file


!!! warning 
    If continue for the `multipleworkflow` project is set to 'false' and the project folder allready exists, a message will appear asking to confirm or deny the deletion of the pre-existing folder.  
    If continue for any of the samples in a `multipleworkflow` project is set to `false` and the corresponding subfolder already exists, a message will appear at stdout to confirm or deny the deletion of the pre-existing folder. In this case, if the DoViP stdout is redirected to a file, the message will not be vissible and DoViP will not progress. 