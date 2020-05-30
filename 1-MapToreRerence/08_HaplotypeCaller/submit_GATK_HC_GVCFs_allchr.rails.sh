#! /bin/bash

#$ -wd /u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam
#$ -l highp,h_rt=1:00:00,h_data=1G
#$ -N submtHCrail
#$ -o /u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/log/gVCF
#$ -e /u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/log/gVCF
#$ -m abe
#$ -M dechavezv

SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/08_HaplotypeCaller

QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

cd /u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam

for i in ./*Filtered.bam; do
        $QSUB $SCRIPTDIR/run_GATK_HC_GVCFs.rails.sh ${i}
done
