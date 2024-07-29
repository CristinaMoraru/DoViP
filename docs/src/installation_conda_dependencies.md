# DoViP dependencies and their installation

## geNomad

geNomad use and installation is described in detail [here](https://github.com/apcamargo/genomad).
Below is the installation procedure we used on our servers.
```
mamba create -p path/to/conda_genomad -c conda-forge -c bioconda genomad

# database setup
conda activate conda_genomad
cd /path/for/databases
genomad download-database .
```

## VIBRANT

VIBRANT use and installation is described in detail [here](https://github.com/AnantharamanLab/VIBRANT/tree/master).
Below is the installation procedure we used on our servers.
```
# env
conda create -n conda_VIBRANT
conda activate conda_VIBRANT

# dependencies
conda install -c bioconda hmmer
conda install -c bioconda prodigal
conda install -c bioconda biopython
conda install -c anaconda pandas
conda install matplotlib
conda install seaborn
conda install -c anaconda numpy
conda install scikit-learn

# install VIBRANT itself
cd path/for/vibrant/repo
git clone https://github.com/AnantharamanLab/VIBRANT
chmod -R 777 VIBRANT/

# database
cd databases
pip install --upgrade scikit-learn==0.21.3
pip install --upgrade numpy==1.17.0
python3 VIBRANT_setup.py 
```

## VirSorter2

VirSorter 2 use and installation are detailed [here](https://github.com/jiarong/VirSorter2).
Below is the installation procedure we used on our servers.
```
# create env and instal, virsorter2
conda create -p path/to/conda_virsorter2
mamba activate path/to/conda_virsorter2
mamba install -c conda-forge -c bioconda virsorter=2

# databases
cd conda_virsorter2/
virsorter setup -d db -j 4
```

## DeepVir Finder

DeepVir Finder use and installation are detailed [here](https://github.com/jessieren/DeepVirFinder).
Below is the installation procedure we used on our servers.
```
# create env
conda create -p /path/to/conda_DVF python=3.6 numpy theano=1.0.3 keras=2.2.4 scikit-learn Biopython h5py
conda activate conda_DVF

# clone the git repo
cd path/for/repo
git clone https://github.com/jessieren/DeepVirFinder
```

## CheckV

CheckV use and installation are detailed [here](https://bitbucket.org/berkeleylab/checkv/src/master/).
Below is the installation procedure we used on our servers.
```
# env
conda create -p path/to/conda_checkV
conda activate conda_checkV

#
conda install -c conda-forge -c bioconda checkV


# database
cd path/for/databases/
checkv download_database ./
```

## PhaBox

PhaBox use and installation are detailed [here](https://github.com/KennthShang/PhaBOX).
Below is the installation procedure we used on our servers.
```
cd path/for/repo
git clone https://github.com/KennthShang/PhaBOX
cd PhaBOX/
conda env create -f webserver.yml -p path/for/conda_PhaBOX
conda activate conda_PhaBOX

# databases
pip install gdown
gdown  --id 1hjACPsIOqqcS5emGaduYvYrCzrIpt2_9
gdown  --id 1E94ii3Q0O8ZBm7UsyDT_n06YekNtfV20

path/for/repo/unzip phagesuite_database.zip  > /dev/null
path/for/repo/unzip phagesuite_parameters.zip  > /dev/null


cp blastxml_to_tabular.pypath/for/conda_PhaBOX/bin/blastxml_to_tabular.py
chmod 777 path/for/conda_PhaBOX/bin/blastxml_to_tabular.py
```