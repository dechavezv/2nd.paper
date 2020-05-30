#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav/Bams.Filtered
#$ -l h_rt=30:00:00,h_data=27G,highp
#$ -N HC_MW_16_bcbr04
#$ -o /u/scratch/d/dechavez/MW/GVCFs/log/reports.chr16_bcbr04
#$ -e /u/scratch/d/dechavez/MW/GVCFs/log/reports.chr16_bcbr04
#$ -m abe
#$ -M dechavezv

#highmem

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav/Bams.Filtered

export BAM=bcbr04_Aligned.MarkDup_Filtered.bam
export ID=bcbr04

java -jar -Xmx20g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
-L chr16 \
-I ${BAM} \
-o /u/scratch/d/dechavez/MW/GVCFs/${ID}_chr16.g.vcf.gz
