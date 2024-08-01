# Project definition 

DoViP works with the concept of projects. A project represents a folder in which the DoViP outputs are saved, plus a binary file encoding project-specific information. 

## `Singleworkflow` projects

In `singleworkflow` mode, a project is represented by the sample folder and a binary file. A simplified example is show below.
```plaintext
single_workflow_project_name/ 
    ├── output_folders ... 
    ├── ... 
    ├── ...
    └── sproj.binary 
```

## `Multipleworkflow` projects
In multipleworkflow mode, a project is represented by the main project folder, subfolders for each of the samples, and the binary file. And example is shown below.  
```plaintext
multiple_workflow_project_name/ 
    ├── sample1_subfolder/ 
    ├── sample2_subfolder/ 
    ├── sample3_subfolder/ 
    └── mproj.binary 
```

Basically, a `multipleworkflow` project comprises several singleworkflow projects:
```plaintext
multiple_workflow_project_name/ 
    ├── sample1_subfolder/ 
    |    ├── output_folders ... 
    |    ├── ... 
    |    ├── ...
    |    └── sproj.binary 
    ├── sample2_subfolder/ 
    |    ├── output_folders ... 
    |    ├── ... 
    |    ├── ...
    |    └── sproj.binary 
    ├── sample3_subfolder/
    |    ├── output folders ... 
    |    ├── ... 
    |    ├── ...
    |    └── sproj.binary  
    └── mproj.binary 
```

