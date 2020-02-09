#!/bin/bash

#$ -l highmem,highp,h_rt=22:00:00,h_data=35G
#$ -N GVCF.HC.Rails
#$ -cwd
#$ -m bea
#$ -o /u/home/d/dechavez/project-rwayne/rails.project/gvcf/log/gvcf4.1.14.out
#$ -e /u/home/d/dechavez/project-rwayne/rails.project/gvcf/log/gvcf4.1.14.err
#$ -M dechavezv

## highmem

# then load your modules:
. /u/local/Modules/default/init/modules.sh
module load java
module load samtools
source activate gatk-intel
                                     
export DIREC=/u/home/d/dechavez/project-rwayne/rails.project/bams/filtered.bam.files
export BAM=${1}
export Reference=/u/home/d/dechavez/project-rwayne/rails.project/reference.genomes/InaccesibleRail/InaccesibleRail.fa
export vcf=/u/home/d/dechavez/project-rwayne/rails.project/gvcf
export temp=/u/scratch/d/dechavez/rails.project/temp

cd ${DIREC}

mkdir -p ${vcf}/log
mkdir -p ${vcf}/Inv.HC_VCF
mkdir -p ${vcf}/tmp

echo "#######"
echo "Haplotype Caller for '$1' "
echo "########"

/u/home/d/dechavez/project-rwayne/gatk-4.1.4.1/gatk --java-options "-Xmx30G" \
HaplotypeCaller \
-R ${Reference} \
-I ${BAM} \
-O ${vcf}/${BAM%.bam}.g.vcf.gz \
-ERC BP_RESOLUTION \
-mbq 10 \
--output-mode EMIT_ALL_ACTIVE_SITES \
-dont-use-soft-clipped-bases

echo "#######"
echo "Done haplotype calling for '$1'"     
echo "########"
