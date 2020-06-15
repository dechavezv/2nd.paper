#! /bin/bash
#$ -l h_rt=24:00:00,h_data=1G,arch=intel*
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

#Run this when you dont provide enought time for the first batch of jobs to complete

for Dir in Dir*; do (cd $Dir && /
if [ -f $(printf ${PWD} | perl -pe 's/.*dir_\d+\/Dir_(.*)/prank_\1.best.fas/g') ]; /
then :;else ./prank -d=$(printf ${PWD} | perl -pe 's/.*dir_\d+\/Dir_(.*)/\1/g') -o=prank_$(printf ${PWD} | perl -pe 's/.*dir_\d+\/Dir_(.*)/\1/g') -t=tree.txt -F -once;fi)done);done
