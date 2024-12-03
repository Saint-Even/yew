#!/bin/bash

#usage
#./subSeqFq.sh <N:int>
#arg1: n of subsample size

#purpose
#automatically grabs all nearby files ending in fastq.gz
#files must be paired end and there must be both reads, named as <filename>_R1.fastq.gz and <filename>_R2.fastq.gz
#runs 2 jobs in parallel on 2 cores and maintains paired matching
#returns randomly subsetted and gzipped files, does not modify compression
#return is named: sub<N>_<filename>.fastq.gz
#NOTE: running twice will subset your subsets which will be  named sub<N2>_sub<N1>_<filename>.... etc

if [ -z "$1" ]  || ! [ "$1" -eq "$1" ]
then
	echo "Argument 1 must be an Int see usage note"
	exit 1
fi

size=$1
#grab all Read 1 fastq.gz files, strip "_R1.fastq.gz" from end
files=$(ls *_R1.fastq.gz | sed s:_R1.fastq.gz::)
#build a list of files for R1 and R2
filesR1=""
filesR2=""
for f in ${files}
do
filesR1+=" ${f}_R1"
filesR2+=" ${f}_R2"
done

#Test parameters
echo "Beginning subset processing on:"
#echo size: $size
#echo files: $files
echo filesR1: $filesR1
echo filesR2: $filesR2

#test file outputs
#parallel -j 2 \
#	"echo size${size}_{}.test
#	echo filler > size${size}_{}.test
#	gzip -k size${size}_{}.test" \
#::: ${filesR1} ${filesR2}

parallel -j 2 \
 	"seqtk sample -s 777 {}.fastq.gz ${size} > sub${size}_{}.fastq
	gzip sub${size}_{}.fastq" \
::: ${filesR1} ${filesR2}
