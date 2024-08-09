## Variant 1: Step by step

### 1. Create the conda environment for DoViP and install Julia programming language

```
# create conda env
conda create -p /path/toward/conda_DoViP
conda activate /path/toward/conda_DoViP

# download and install julia version 1.10.0
cd /path/toward/conda_DoViP
wget https://julialang-s3.julialang.org/bin/linux/x64/1.10/julia-1.10.0-linux-x86_64.tar.gz
tar -xzvf julia-1.10.0-linux-x86_64.tar.gz
rm julia-1.10.0-linux-x86_64.tar.gz
mkdir bin

# make a symbolic link of the julia executable in the /path/toward/conda_DoViP/bin/ folder
ln -s /path/toward/conda_DoViP/julia-1.10.0/bin/julia /path/toward/conda_DoViP/bin/julia

```


### 2. Bring the DoViP repo

```
cd /path/toward/conda_DoViP
git clone https://github.com/CristinaMoraru/DoViP.git

mv DoViP/* .
rm DoViP

# give permissions to the folder where julia saved its libraries
cd share
chmod 777 -R julia
```

### 3. Refresh the DoViP conda environment

```
conda deactivate conda_DoViP
conda activate /path/toward/conda_DoViP

```

### 4. Instantiate DoViP libraries

```

cd /path/toward/conda_DoViP/

julia -e 'using Pkg; Pkg.activate("DoViP_App.jl"); Pkg.instantiate()' 

```
Instantiation is necessary to bring on your machine the packages on which DoViP depends. 

!!! note
    After successfull instantation Julia will atempt to start DoViP directly. Obviously, because the arguments are missing, it will give an error message:  " Aborting Program because the mandatory parameter 'projtype' is missing. Please make sure you input it correctly and try again. 

    WARNING: --output requested, but no modules defined during run
    lld: error: cannot open /home/cmoraru/miniconda3/envs/conda_DoViPv0.8/share/julia/compiled/v1.10/DoViP_App/jl_J195Bq: No such file or directory
    ◓ DoViP_App
    62 dependencies successfully precompiled in 56 seconds
    1 dependency had output during precompilation:
    ┌ DoViP_App
    │  [Output was shown above]
    └  ""

    Ignore the message, it actually means that DoViP was successfully installed.

    


### 5.Test installation

```
DoViP --help
```

You should get the following message: "DoViP - a workflow for virus prediction in metagenomes."


## Variant 2: From a conda package
- to be prepared