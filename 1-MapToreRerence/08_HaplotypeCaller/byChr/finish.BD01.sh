#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav/Bams.Filtered
#$ -l h_rt=42:00:00,h_data=22G,highp
#$ -t 01-38:1
#$ -N HC_MW_12
#$ -o /u/scratch/d/dechavez/MW/GVCFs/log/reports
#$ -e /u/scratch/d/dechavez/MW/GVCFs/log/reports
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav/Bams.Filtered

export BAM=$(ls bcbr01_Aligned.MarkDup_Filtered.bam)
export ID=${BAM%_Aligned.MarkDup_Filtered.bam}

java -jar -Xmx16g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
-L chr$(printf %02d $SGE_TASK_ID) \
-I ${BAM} \
-o /u/scratch/d/dechavez/MW/GVCFs/${ID}_chr12.g.vcf.gz
