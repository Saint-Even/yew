#!/bin/bash

echo running fastQC for the following files:

for f in *.fastq.gz
do
	echo $f
done

for f in *.fastq.gz
do
	fastqc $f
done

echo "running multiqc"
multiqc .


mkdir qcResults
mv *fastqc* qcResults
mv *multiqc* qcResults

