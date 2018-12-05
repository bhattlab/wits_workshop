# wits_workshop

[ ] Need to bring datasets with us -- set up access to Wits cluster asap (Eli, Ryan)
[x] Set up a repo for workshop (Eli)
[x] List dependencies for each module in the github readme (Fiona, Eli)
[ ] Docker example workflow implementation (Eli)


# Workflow Dependencies

## Preprocessing

  - fastqc=0.11.7
  - trim-galore 
  - seqkit=0.9.1
  - bwa=0.7.17
  - samtools
  - pip
  - pip:
    - snakemake==5.3.0
    - cookiecutter==1.6.0
    - datrie==0.7.1

## Classification

  - kraken
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

