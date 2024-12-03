#!/bin/bash

#clear output dir
rm -r output/
mkdir output

#report input contents for user reference
echo "Files.vcf currently in input:"
echo "========================"
cd input
ls -1 *.vcf
cd ..
echo "========================"
echo "Files in input must have names formatted:"
echo "<YEAR>_P<N<optional>>.vcf eg. 2020_P1.vcf, 2021_P2raw.vcf"


#specify set of targets Train and Validate: years, plates
#...user loop for each
trYears=(2019)
trPlates=(P1Common)
vaYears=(2020)
vaPlates=(P6Filtered P7Filtered P8Filtered P10Filtered P11Filtered)
#...report entry

#test for existing input files
#for T and V make all combinations raw fields
#for T and V test for existing formatted, make list of raw fields
#report missing files
for y in "${trYears[@]}"; do
    for p in "${trPlates[@]}"; do
        try="${y}_${p}.vcf"
        if [ -f "./input/${try}" ]; then
            cp ./input/${try} ./output/${try}.Train
        else
            echo "File not found: ${try}"
        fi
    done
done


for y in "${vaYears[@]}"; do
    for p in "${vaPlates[@]}"; do
        try="${y}_${p}.vcf"
        if [ -f ./input/${try} ]; then
            cp ./input/${try} ./output/${try}.Validate
        else
            echo "File not found: ${try}"
        fi
    done
done

#make all combinations of T and V raw fields
#iterate through both make a set of combos
#exclude same

declare -a tSetClean
declare -a vSetClean

for t in output/*.vcf.Train; do
    tSetClean+=($(echo "${t}" | sed s:".vcf.Train":"":g | sed s:"output/":"":g ))
done

for v in output/*.vcf.Validate; do
    vSetClean+=($(echo "${v}" | sed s:".vcf.Validate":"":g | sed s:"output/":"":g ))
done

echo "T set: ${tSetClean[@]}"
echo "V set: ${vSetClean[@]}"

for t in "${tSetClean[@]}"; do
    for v in "${vSetClean[@]}"; do
        if [[ ${t} == ${v} ]]; then
            echo "Excluding same: ${t}, ${v}"
        else
            tY=$(echo ${t} | sed s:_[1234567890P]*::)
            tP=$(echo ${t} | sed s:[1234567890]*_::)
            vY=$(echo ${v} | sed s:_[1234567890P]*::)
            vP=$(echo ${v} | sed s:[1234567890]*_::)
            tar="cassette_${tY}${tP}T-${vY}${vP}V"
            echo ${tar}
            mkdir ./output/${tar}
            touch ./output/${tar}/"key_${tY}${tP}T-${vY}${vP}V"
            cp output/${t}.vcf.Train ./output/${tar}/
            cp output/${v}.vcf.Validate ./output/${tar}/
        fi
    done
done

#clean up temp output .train and .validate files
for f in output/*.vcf.*; do
    rm ${f}
done

exit 0
