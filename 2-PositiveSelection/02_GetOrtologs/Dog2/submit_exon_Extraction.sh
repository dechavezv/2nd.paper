#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/02_GetOrtologs/Dog2
#$ -l highp,h_rt=02:00:00,h_data=1G
#$ -N ortolog
#$ -o /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/02_GetOrtologs/Dog2/log/MkrIlAdp
#$ -e /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/02_GetOrtologs/Dog2/log/MkrIlAdp
#$ -m abe
#$ -M dechavezv


SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/02_GetOrtologs/Dog2

QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

# Important change the pathway to your current path
cd /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/02_GetOrtologs/Dog2

# chan the number 2 for the name you chose for your Dog folder (eg. Dog4 will be Extract_Exons_3.sh ${i} 4).
# See the readme.txt for more details

for i {1..7}; do
	$QSUB $SCRIPTDIR/Extract_Exons_3.sh ${i} 2
#	sleep 30m
done
