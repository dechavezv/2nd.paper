#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/Clup/reads/TG
#$ -l h_rt=24:00:00,h_data=14G,h_vmem=40G,arch=intel*
#$ -t 01-2:1
#$ -N HC_TG_38
#$ -o /u/home/d/dechavez/project-rwayne/Clup/reads/TG/log/reports
#$ -e /u/home/d/dechavez/project-rwayne/Clup/reads/TG/log/reports
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/home/d/dechavez/project-rwayne/Clup/reads/TG

export BAM=$(ls $(printf %02d $SGE_TASK_ID)_*Aligned.MarkDup_Filtered.bam)
export ID=${BAM%_Aligned.MarkDup_Filtered.bam}

java -jar -Xmx14g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
-L chr38 \
-I ${BAM} \
-o /u/home/d/dechavez/project-rwayne/Clup/reads/TG/GVCF/${ID}_chr38.g.vcf.gz
