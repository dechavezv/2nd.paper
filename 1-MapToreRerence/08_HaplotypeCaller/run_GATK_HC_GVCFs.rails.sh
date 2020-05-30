#!/bin/bash
#$ -wd /u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam
#$ -l highmem,h_rt=190:00:00,h_data=30G,highp,h_vmem=50G
#$ -N HC_rail
#$ -o /u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/log/gvcf/log/reports
#$ -e /u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/log/gvcf/log/reports
#$ -m abe
#$ -M dechavezv

# then load your modules:
. /u/local/Modules/default/init/modules.sh
module load java
module load samtools
source activate gatk-intel
                                     
export DIREC=/u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam
export BAM=${1}
export Reference=/u/home/d/dechavez/project-rwayne/rails.project/reference.genomes/InaccesibleRail/InaccesibleRail.fa
export temp=/u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/temp

cd ${DIREC}

echo "#######"
echo "Haplotype Caller for '$1' "
echo "########"

/u/home/d/dechavez/project-rwayne/gatk-4.1.4.1/gatk --java-options "-Xmx30G" \
HaplotypeCaller \
-R ${Reference} \
-I ${BAM} \
-O ${DIREC}/${BAM%.bam}.g.vcf.gz \
-ERC BP_RESOLUTION \
-mbq 10 \
--output-mode EMIT_ALL_ACTIVE_SITES \
-dont-use-soft-clipped-bases

echo "#######"
echo "Done haplotype calling for '$1'"     
echo "########"
