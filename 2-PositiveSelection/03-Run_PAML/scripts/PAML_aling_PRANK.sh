#! /bin/bash
#$ -l highp,h_rt=32:00:00,h_data=1G
#$ -pe shared 1
#$ -N fourHD_Indel_PAML_I
#$ -cwd
#$ -m bea
#$ -o ./fourHD_PAML_I.out
#$ -e ./fourHD_PAML_I.err
#$ -M dechavezv

echo '############'
echo Aling orthologos genes with Prank
echo '############'
for dir in Dir_*;do (cd $dir && /
for file in *.fasta;do (sed -i -r 's/(>\w+)\|\w+\|\w+\|./\1/g' $file && /
./prank -d=$file -o=prank_$file -t=tree.txt -F -once);done && /
);done
