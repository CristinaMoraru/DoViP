# DoViP

The user manual for DoViP contains information about its installation and running procedures and is found [here](https://cristinamoraru.github.io/DoViP/index.htlm). 


## Installation of DoViP step by step (recommended)

### Create a conda environment and install Julia


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


### Bring the DoViP repo

```
cd /path/toward/conda_DoViP
git clone https://github.com/CristinaMoraru/DoViP.git

mv DoViP/* .
rm DoViP

# give permissions to the folder where julia saved its libraries
cd share
chmod 777 -R julia
```

### Refresh conda environment

```
conda deactivate conda_DoViP
conda activate /path/toward/conda_DoViP

```

### Instantiate DoViP libraries

```

cd /path/toward/conda_DoViP/

julia -e 'using Pkg; Pkg.activate("DoViP_App.jl"); Pkg.instantiate()' 

```
Instantiation is necessary to bring on your machine the packages on which DoViP depends. After instantiation, it will attempt to start DoViP already, and terefore you will see an error message:  


## Instalation of DoViP from a conda pack   fds