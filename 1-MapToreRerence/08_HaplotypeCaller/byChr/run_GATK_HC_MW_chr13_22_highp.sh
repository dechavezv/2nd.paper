#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav/Bams.Filtered
#$ -l h_rt=30:00:00,h_data=22G,highp
#$ -t 05-5:1
#$ -N HC_MW_22
#$ -o /u/scratch/d/dechavez/MW/GVCFs/log/reports
#$ -e /u/scratch/d/dechavez/MW/GVCFs/log/reports
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav/Bams.Filtered

export BAM=$(ls bcbr$(printf %02d $SGE_TASK_ID)_Aligned.MarkDup_Filtered.bam)
export ID=${BAM%_Aligned.MarkDup_Filtered.bam}

java -jar -Xmx16g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
-L chr22 \
-I ${BAM} \
-o /u/scratch/d/dechavez/MW/GVCFs/${ID}_chr22.g.vcf.gz
