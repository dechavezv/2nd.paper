#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav/Bams.Filtered
#$ -l highmem,highp,h_rt=24:00:00,h_data=22G,arch=intel*
#$ -t 01-38:1
#$ -N HC_BD_allChr
#$ -o /u/scratch/d/dechavez/BD/GVCFs/log/HC_BD_allChr.bsve313
#$ -e /u/scratch/d/dechavez/BD/GVCFs/log/HC_BD_allChr.bsve313 
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav/Bams.Filtered

export BAM=bsve313_Aligned.MarkDup_Filtered.bam
export ID=bsve313

java -jar -Xmx16g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
-L chr$(printf %02d $SGE_TASK_ID) \
-I ${BAM} \
-o /u/scratch/d/dechavez/BD/GVCFs/${ID}_chr$(printf %02d $SGE_TASK_ID).g.vcf.gz
