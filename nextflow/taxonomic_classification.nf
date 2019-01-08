#!/usr/bin/env nextflow

params.in = "test_data/test.fq" //can be overriden with --in on the command line
data = file(params.in)

params.db = "/labs/asbhatt/data/program_indices/kraken2/kraken_custom_oct2018/genbank_bacteria"
params.readlen = 150
params.tax_level = 'S'

process kraken {
	input: file d from data
	output: set "out_report.tsv", "out_raw.tsv" into kraken_ch
	cpus 1
	time '1h'
	memory '1GB' //'160 GB'

	"""
	#!/usr/bin/env bash

	echo time kraken2 --db ${params.db} --threads ${task.cpus} \
	--report out_report.tsv --output out_raw.tsv \
	--quick --memory-mapping \
	${data} > out_report.tsv
	touch out_raw.tsv
	"""
}

process bracken {
  input: file f from kraken_ch
  output: file "report.bracken" into bracken_ch
	cpus 1
	time '1h'
	memory '1GB' //'64GB'

	"""
	#!/usr/bin/env bash

	echo bracken -d $params.db -i $f \
	-o report.bracken -r {params.readlen} -l {params.tax_level} > report.bracken
	"""

}

/*
rule kraken:
	input: lambda wildcards: sample_reads[wildcards.samp]
	output: "classify/raw/{samp}.krak"
	resources:
		mem=320,
		time=6
	threads: 1
	shell:
		"kraken --db {krak} ".format(krak = config['krakendb']) +
		" {input} --output {output} --threads {threads}" #--preload
*/
