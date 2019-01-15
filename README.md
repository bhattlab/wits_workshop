# Running the taxonomic classification demonstration workflow

### 1. Set up conda, singularity and nextflow, clone the Git repository

```
cd ~
wget -qO- https://get.nextflow.io | bash
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3*.sh #accept the defaults
conda install -c conda-forge singularity
git clone https://github.com/bhattlab/wits_workshop.git
```

### 2. Running the workflow

```
cd ~
mkdir test_run; cd test_run
~/nextflow ../wits_workshop/nextflow/taxonomic_classification/taxonomic_classification.nf  --tax_level S -resume -profile scg --in ../wits_workshop/nextflow/test_data/*.fq
```

# wits_workshop

[x] Need to bring datasets with us -- set up access to Wits cluster (Eli, Ryan)  
[x] Set up a repo for workshop (Eli)  
[x] List dependencies for each module in the github readme (Fiona, Eli)  
[x] Example workflow implementation and singularity container (Eli)  


# Workflow Dependencies

## Preprocessing

  - fastqc
  - trim-galore
  - seqkit
  - bwa
  - samtools
	- prinseq
	- super-deduper
	- seqtk

## Classification

  - kraken2
	- krona (with databases)
	- bracken
  - datrie
  - r-ggplot2
  - r-doby
  - r-rcolorbrewer
  - r-scales
  - r-plyr

## Assembly

  - quast
  - spades
  - megahit

## Strain comparisons

  - bwa
  - samtools
  - bamtools
  - bedtools
  - MUSCLE
  - FastTree
  - r-ggplot2
  - bioconductor-ggtree
  - r-phangorn

## Long read assembly

	- python>3.5
  - pilon
  - bwa
  - minimap2
  - canu=1.7.1
  - samtools
  - bcftools
  - bedtools #used with tombo
  - bedops #used with tombo
  - biopython
  - pip
  - tabix
  - ncurses=6.1
  - tensorflow #makes medaka work
  - mummer
  - circlator
  - ONT albacore
	- quickmerge
