#! /bin/bash
#$ -wd /u/scratch/d/dechavez/IndelReal
#$ -l h_rt=42:00:00,h_data=22G,highp
#$ -t 01-4:1
#$ -N HC_MW_X
#$ -o /u/scratch/d/dechavez/IndelReal/log/reports
#$ -e /u/scratch/d/dechavez/IndelReal/log/reports
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/scratch/d/dechavez/IndelReal

export BAM=$(ls bcbr$(printf %02d $SGE_TASK_ID)_Aligned.MarkDup_Filtered.bam)
export ID=${BAM%_Aligned.MarkDup_Filtered.bam}

java -jar -Xmx16g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
-L chrX \
-I ${BAM} \
-o /u/scratch/d/dechavez/MW/GVCFs/${ID}_chrX.g.vcf.gz
