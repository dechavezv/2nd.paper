#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/rails.project/gvcf
#$ -l highp,h_rt=1:00:00,h_data=1G
#$ -N submtHCrail
#$ -o /u/home/d/dechavez/project-rwayne/rails.project/gvcf/log/gVCF
#$ -e /u/home/d/dechavez/project-rwayne/rails.project/gvcf/log/gVCF
#$ -m abe
#$ -M dechavezv

SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/08_HaplotypeCaller

QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

cd /u/home/d/dechavez/project-rwayne/rails.project/bams/filtered.bam.files

for i in ./*.bam; do
        $QSUB $SCRIPTDIR/run_GATK_HC_GVCFs.rails.sh ${i}
done
