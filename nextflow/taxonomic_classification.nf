#!/usr/bin/env nextflow


//The parameters below can all be overridden with --parametername on the commandline (e.g. --in or --dataset_table)
params.in = "test_data/*.f*q"
params.db = "/labs/asbhatt/data/program_indices/kraken2/kraken_unmod/standard"
params.readlen = 150
params.tax_level = 'S'
params.dataset_table = 'test_data/datasets.tsv'

data = file(params.in)
dataset_table = file(params.dataset_table)

process kraken {
	//publishDir 'outs/' //, mode: symlink, overwrite: true
		//don't publish to the outs folder, as this is an intermediate
		//publishing the results can be done by symlinking or copying the outputs
	input: file d from data
	output: file "${d.baseName}_kraken.tsv" into kraken_ch
	cpus 1
	time '1h'
	memory '10GB' //'160 GB'

	"""
	#!/usr/bin/env bash

	time kraken2 --db $params.db --threads $task.cpus \
	--report ${d.baseName}_kraken.tsv \
	--quick --memory-mapping \
	$d
	"""
}

process bracken {
	publishDir 'outs/'
  input: file f from kraken_ch
  output: file "${f.baseName}_bracken.tsv" into bracken_ch
	cpus 1
	time '1h'
	memory { 8.GB * task.attempt }

	"""
	#!/usr/bin/env bash

	bracken -d $params.db -i $f \
	-o ${f.baseName}_bracken.tsv -r $params.readlen -l $params.tax_level \
	"""
}
bracken_ch.into{bracken_ch1; bracken_ch2}

process collect_results {
	publishDir 'outs/'
	input:
		file data from dataset_table
		file f from bracken_ch1.collect()
	output: file 'class_long.tsv' into collect_results_ch
	cpus 1
	time '1h'
	memory {2.GB * task.attempt }

	"""
	collate_results.py $params.tax_level $data class_long.tsv $f
	"""
}

process barplot {
	publishDir 'outs/'
	input: file f from collect_results_ch
	output: file 'barplot.pdf' into barplot_ch

	"""
	composition_barplot.R $f barplot.pdf
	"""
}


process krona {
	publishDir 'outs/'
	input: file k from bracken_ch2
	output: file "krona_${k}.html" into krona_ch
	cpus 1
	time '1h'
	memory '1GB'

	"""
	ktImportTaxonomy -m 3 -s 0 -q 0 -t 5 -i ${k} -o krona_${k}.html \
	 -tax \$(which kraken2 | sed 's/envs\\/classification2.*\$//g')/envs/classification2/bin/taxonomy
	"""
}
