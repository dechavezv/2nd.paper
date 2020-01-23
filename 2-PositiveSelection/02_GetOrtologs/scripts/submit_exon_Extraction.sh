#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/02_GetOrtologs
#$ -l highp,h_rt=05:00:00,h_data=1G
#$ -N ortolog
#$ -o /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/02_GetOrtologs/log
#$ -e /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/02_GetOrtologs/log
#$ -m abe
#$ -M dechavezv


SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/02_GetOrtologs/scripts

QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

# chan the name of the spescies with the name your genome (eg. red.fox will be Extract_Exons_3.sh ${i} red.fox).
# See the readme.txt for more details

export Spescies=red.fox.fa

for i in {1..7}; do
	$QSUB $SCRIPTDIR/Extract_Exons_3.sh ${i} ${Spescies}
#	sleep 5h
done

sleep 2h

cd red.fox.fa_Output
touch ../../../data/Genomes.canids.Jan.2020.Ortologs.fasta/${Spescies}
for file in *.fa; do (echo $file && cat $file >> ../../../data/Genomes.canids.Jan.2020.Ortologs.fasta/${Spescies});done
cd ../
rm -rf red.fox.fa_DirCanis*
rm -rf red.fox.fa_Output*
