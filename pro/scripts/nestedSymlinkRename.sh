#!/bin/bash

#creates sym links in target dir

nested

sou="/home/holdens/holdensQNAP/LIBS/gbs_snp/cassetteGBS/synergySRG/2019"
ddd="NS.*"
f="variantsImputed.vcf"
tar="/home/holdens/holdensQNAP/PROC/GEBVeR/commmonMarker/input"

for d in  ${sou}/${ddd}
do
  echo "Enter: ${d}"
  (cd "${d}" || exit
  
  echo "Build name for: ${f}"
  n=$(basename ${d} | sed s:NS.*.Brandon::g | sed s:_:P:g)
  n+=".vcf"
  echo ${n}

  echo "Create renamed links in ${tar}"
  ln -ifs ${d}/${f} ${tar}/${n}
  )
done
