params.input = "input.txt"

in_file = file(params.input)

process step1{
	input: file in_file //one input
	output: file "output1_*.txt" into step1_ch //many outputs
	publishDir "results/"

	script:
	"""
	for OUTNUM in `seq 1 10`; do
		(cat $in_file; echo 'this is the output from step 1') > output1_\$OUTNUM.txt
	done
	"""
}

process step2{
	input: file f from step1_ch //one input
	output: file "output2.txt" into step2_ch //one output
	publishDir "results/"

	script:
	"""
	(cat $f; echo 'this is the output from step 2') > output2.txt
	"""
}

process step3{
	input: file f from step2_ch.collect() //many inputs
	output: file "output3.txt" into step3_ch //one output
	publishDir "results/"

	script:
	"""
	(cat $f; echo 'this is the output from step 3') > output3.txt
	"""
}
