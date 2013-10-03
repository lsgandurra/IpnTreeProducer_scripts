#!/bin/bash

syntax="Syntax ${0} {sampleName}"
if [[ -z ${1} ]]
then
  echo ${syntax}
  exit 1
fi
sample=${1}

cat ${sample}/res/*stdout | grep -A 14 "TrigReport ---------- Modules in Path: p ------------" > dump_${sample}.out

name[1]="ZToMMGHltFilter"
name[2]="kt6PFJets"
name[3]="noscraping"
name[4]="primaryVertexFilter"
name[5]="ZToMMGMuonsCountFilter"
name[6]="ZToMMGLooseMuons"
name[7]="ZToMMGLooseMuonsCountFilter"
name[8]="ZToMMGTightMuons"
name[9]="ZToMMGTightMuonsCountFilter"
name[10]="ZToMMGDimuons"
name[11]="ZToMMGDimuonsFilter"
name[12]="totoana"

for index in `seq 1 12`
do
	Visited[${index}]=`cat dump_${sample}.out | grep -w "${name[${index}]}" | awk 'BEGIN {SUM=0} {SUM+=$4} END {print SUM}'`
	Passed[${index}]=`cat dump_${sample}.out | grep -w "${name[${index}]}" | awk 'BEGIN {SUM=0} {SUM+=$5} END {print SUM}'`
	Failed[${index}]=`cat dump_${sample}.out | grep -w "${name[${index}]}" | awk 'BEGIN {SUM=0} {SUM+=$6} END {print SUM}'`
	Error[${index}]=`cat dump_${sample}.out | grep -w "${name[${index}]}" | awk 'BEGIN {SUM=0} {SUM+=$7} END {print SUM}'`
	echo -e "${name[${index}]}\t\t${Visited[${index}]}\t\t${Passed[${index}]}\t\t${Failed[${index}]}\t\t${Error[${index}]}"
done

rm dump_${sample}.out

exit 0
