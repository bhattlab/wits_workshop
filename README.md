# wits_workshop

[ ] Need to bring datasets with us -- set up access to Wits cluster (Eli, Ryan)  
[x] Set up a repo for workshop (Eli)  
[x] List dependencies for each module in the github readme (Fiona, Eli)  
[/] Docker example workflow implementation and singularity container (Eli)  


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
