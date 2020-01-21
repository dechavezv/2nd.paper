#!/bin/bash
#$ -l highp,h_rt=10:00:00,h_data=1G
#$ -pe shared 1
#$ -N I
#$ -cwd
#$ -m bea
#$ -o ./copy_I.out
#$ -e ./copy_I.err
#$ -M dechavezv

for Dir in dir*; do (cd $Dir && for dir in Tree_*; do (cd $dir && /
cd modelA/Omega1 && /
grep 'lnL' out > out_modelA && /
mv out_modelA .. && /
cd .. && /
mv out_modelA .. && /
cd .. && /
cd modelAnull/Omega1 && /
grep 'lnL' out > out_modelAnull && /
mv out_modelAnull .. && /
cd .. && /
mv out_modelAnull .. && /
cd .. && /
sed -i -r 's/^\S+\s+(\w+)\s+\S+\s+(\w+)\S+\s+(\S+)\s+\S+/\1\t\2\t\3/g' out_modelA && /
sed -i -r 's/^\S+\s+(\w+)\s+\S+\s+(\w+)\S+\s+(\S+)\s+\S+/\1\t\2\t\3/g' out_modelAnull && /
printf '%s\n' "${PWD##*/}" > name_dircetory && /
sed -i -r 's/Tree_Dir_(\w+).fasta/\1/g' name_dircetory && /
paste out_modelA out_modelAnull name_dircetory| column -s $'\t' -t > LTR_PAML.out && /
sed -i -r 's/^(\w+)\s+(\w+)\s+(\S+)\s+(\w+)\s+(\w+)\s+(\S+)\s+(\w+)/\7\t\3\t\6\t\1\t\2\t\4\t\5/g' LTR_PAML.out && /
mv LTR_PAML.out ${PWD##*/}_LTR_PAML.out && /
cp *_LTR_PAML.out /u/home/d/dechavez/project-rwayne/PAML/LRT_color_genes && /
rm *);done);done
