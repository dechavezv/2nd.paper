#! /bin/bash
#$ -l highp,h_rt=12:00:00,h_data=3G
#$ -pe shared 1
#$ -N Prank
#$ -cwd
#$ -m bea
#$ -o ./aling.prank.out
#$ -e ./aling.prank.err
#$ -M dechavezv

echo '############'
echo Aling orthologos genes with Prank
echo '############'

for dir in Dir_*;do (cd $dir && /
for file in *.fasta;do (sed -i -r 's/(>\w+)\|\w+\|\w+\|./\1/g' $file && /
./prank -d=$file -o=prank_$file -t=tree.txt -F -once);done && /
);done
