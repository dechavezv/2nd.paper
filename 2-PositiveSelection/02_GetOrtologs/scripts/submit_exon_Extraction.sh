#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/02_GetOrtologs
#$ -l highp,h_rt=05:00:00,h_data=4G
#$ -N ortolog
#$ -o /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/02_GetOrtologs/log/
#$ -e /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/02_GetOrtologs/log/
#$ -m abe
#$ -M dechavezv


export SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/02_GetOrtologs/scripts
export data=/u/home/d/dechavez/project-rwayne/2nd.paper/data/Genomes.canids.Jan.2020.Ortologs.fasta
export QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

cd ${SCRIPTDIR}
# change the name of the spescies with the name your genome (eg. red.fox will be Extract_Exons_3.sh ${i} red.fox).
# See the readme.txt for more details

#if you have only one spescies
#export Spescies=red.fox
#for i in {1..7}; do ($QSUB $SCRIPTDIR/Extract_Exons_3.sh ${i} ${Spescies}.fa);done

#if you have multiple spescies
for Spescies in $(cat Sps.txt); do (echo $Spescies && \
for i in {1..7}; do ($QSUB $SCRIPTDIR/Extract_Exons_3.sh ${i} ${Spescies}.fa);done);done

sleep 45m

cd ${Spescies}.fa_Output
touch ${data}/${Spescies}.fa
for file in *.fa; do (echo $file && cat $file >> ${data}/${Spescies}.fa);done
cd /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/02_GetOrtologs
rm -rf ${Spescies}.fa_DirCanis*
rm -rf ${Spescies}.fa_Output*

sleep 5m
