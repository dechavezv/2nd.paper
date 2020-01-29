#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/06-Join.GVCFs
#$ -l highp,h_rt=05:00:00,h_data=1G
#$ -N ortolog
#$ -o /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/06-Join.GVCFs/log
#$ -e /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/06-Join.GVCFs/log
#$ -m abe
#$ -M dechavezv


export SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/06-Join.GVCFs/scripts
export data=/u/home/d/dechavez/project-rwayne/2nd.paper/data/g_VCF
export QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

# chan the name of the spescies with the name your genome (eg. red.fox will be Extract_Exons_3.sh ${i} red.fox).
# See the readme.txt for more details

export Spescies=red.fox.fa

for i in {1..38} X MT; do
	$QSUB $SCRIPTDIR/GATK_Join_GVCFs_allCanids_March3_2019.sh ${i} ${Spescies}
	$QSUB $SCRIPTDIR/Reheader_Canids_GVCFs.sh
#	sleep 5h
done

sleep 15m
