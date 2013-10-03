#!/bin/bash

syntax="Syntax ${0} {sampleName}"
if [[ -z ${1} ]]
then
  echo ${syntax}
  exit 1
fi
sample=${1}

cat ${sample}/res/*stdout | grep -A 16 "TrigReport ---------- Modules in Path: p ------------" > dump_${sample}.out

name[1]="kt6PFJets"
name[2]="noscraping"
name[3]="primaryVertexFilter"
name[4]="ZmmgHLTFilter"
name[5]="ZmmgTrailingMuons"
name[6]="ZmmgLeadingMuons"
name[7]="ZmmgDimuons"
name[8]="ZmmgDimuonFilter"
name[9]="ZmmgMergedSuperClusters"
name[10]="ZmmgPhotonCandidates"
name[11]="ZmmgPhotons"
name[12]="ZmmgCandidates"
name[13]="ZmmgFilter"
name[14]="totoana"

for index in `seq 1 14`
do
	Visited[${index}]=`cat dump_${sample}.out | grep -w "${name[${index}]}" | awk 'BEGIN {SUM=0} {SUM+=$4} END {print SUM}'`
	Passed[${index}]=`cat dump_${sample}.out | grep -w "${name[${index}]}" | awk 'BEGIN {SUM=0} {SUM+=$5} END {print SUM}'`
	Failed[${index}]=`cat dump_${sample}.out | grep -w "${name[${index}]}" | awk 'BEGIN {SUM=0} {SUM+=$6} END {print SUM}'`
	Error[${index}]=`cat dump_${sample}.out | grep -w "${name[${index}]}" | awk 'BEGIN {SUM=0} {SUM+=$7} END {print SUM}'`
	echo -e "${name[${index}]}\t\t${Visited[${index}]}\t\t${Passed[${index}]}\t\t${Failed[${index}]}\t\t${Error[${index}]}"
done

rm dump_${sample}.out

exit 0
