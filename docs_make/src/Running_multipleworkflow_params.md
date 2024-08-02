# DoViP multipleworkflow parameters 

## Arguments
When running DoViP in multiworkflow mode, there are only four arguments that need to be given at the command line.

#### `projtype`
  * the only acceptable value here is 'multipleworkflow', and it tells DoViP that it should process multiple samples, one after the other
  * mandatory parameter, no default is given

#### `spd`
  * value: path/to/ouptput_folder
  * in this folder there will be created individual subfolders for each sample
  * mandatory parameter, no default is given

#### `allrefs_params`
  * value: path/to/parameter.tsv
  * it represents a .tsv file where each row represents a sample to be analysed by DoViP and each column represents one argument. 
  * this file should contain values for all arguments detailed in the `singleworkflow` page (see previous page), with the exception of `pd_prefix` (is is not needed, because it is replaced here by the `spd` argument)
  * an example of this .tsv file can be downloaded from [here](helpers/inrefs_params.tsv). Alternatively, you can use for the generation of this input file a [template script using the Julia language](helpers/prep_input.jl) or a [template script using the R language](helpers/prep_input.R).
  * mandatory parameter, no default is given

#### `continue`
  * indicates if the multipleworkflow project should be continued from a previous run
  * possible values: 'true' or 'false'
  * default is 'false'

!!! note 
    if continue is set to 'false' and the project folder allready exists, a message will appear asking to confirm or deny the deletion of the existing folder.

## Example command
Example of calling DoViP in multiworkflow mode:
```
DoViP projtype=multiworkflow continue=false allrefs_params=path/to/tsv_file_with_parameters spd=path/to/output_folder
```

!!! tip
    Due to the high number of arguments needed by DoViP, it is easier to call it in `multipleworkflow` mode even when running one single sample, because in this mode most of parameters are given as a .tsv file. 