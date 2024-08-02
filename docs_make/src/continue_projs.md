# Continuing projects

## Singleworkflow projects

There are several reasons to continue an already finished project:
  * to add/remove results from any of the five initial predictors. For details, see the description of the [`genomad_signal`](Running_singleworkflow_params.md#genomad_signal), [`dvf_signal`](./Running_singleworkflow_params.md#dvf_signal), [`virSorter2_signal`](./Running_singleworkflow_params.md#virSorter2_signal), [`vibrant_signal`](./Running_singleworkflow_params.md#vibrant_signal) and [`viralVerify_signal`](./Running_singleworkflow_params.md#viralVerify_signal) arguments.
  * to continue calculations past the initial predictors step. For details, see the [`stop_after_initial_predictors`](./Running_singleworkflow_params.md#stop_after_initial_predictors) argument.
  * to change the parameters for the final selection of the contigs
  * to resume a failed project (e.g., a project which failed in the VIBRANT step because the name of the conda environment was not correctly setup, can be continued without having to recalculate the first three predictors)


## Multipleworkflow projects