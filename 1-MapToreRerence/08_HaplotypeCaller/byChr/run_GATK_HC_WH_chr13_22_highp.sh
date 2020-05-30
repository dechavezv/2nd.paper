#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav/Bams.Filtered
#$ -l h_rt=32:00:00,h_data=12G,highp,h_vmem=40G
#$ -t 01-08:1
#$ -N HC_WH_22
#$ -o /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav/Bams.Filtered/log/reports
#$ -e /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav/Bams.Filtered/log/reports
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav/Bams.Filtered

export BAM=$(ls $(printf %02d $SGE_TASK_ID)_*Aligned.MarkDup_Filtered.bam)
export ID=${BAM%_Aligned.MarkDup_Filtered.bam}

java -jar -Xmx12g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
-L chr22 \
-I ${BAM} \
-o /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav/Bams.Filtered/${ID}_chr22.g.vcf.gz
