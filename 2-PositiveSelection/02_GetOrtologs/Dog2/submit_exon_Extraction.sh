#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/02_GetOrtologs
#$ -l highp,h_rt=02:00:00,h_data=1G
#$ -N ortolog
#$ -o /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/02_GetOrtologs/log
#$ -e /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/02_GetOrtologs/log
#$ -m abe
#$ -M dechavezv


SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/02_GetOrtologs

QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

# Important change the pathway to your current path
cd /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/02_GetOrtologs

# chan the name of the spescies with the name your genome (eg. red.fox will be Extract_Exons_3.sh ${i} red.fox).
# See the readme.txt for more details

export Spescies=red.fox

for i in {1..7}; do (
	$QSUB $SCRIPTDIR/Extract_Exons_3.sh ${i} ${red.fox}
#	sleep 30m
done
