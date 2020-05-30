#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/Clup/reads/TG
#$ -l h_rt=24:00:00,h_data=8G,h_vmem=30G,arch=intel*
#$ -t 01-2:1
#$ -N HC_TG_X
#$ -o /u/home/d/dechavez/project-rwayne/Clup/reads/TG/log/reports
#$ -e /u/home/d/dechavez/project-rwayne/Clup/reads/TG/log/reports
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/home/d/dechavez/project-rwayne/Clup/reads/TG

export BAM=$(ls $(printf %02d $SGE_TASK_ID)_*Aligned.MarkDup_Filtered.bam)
export ID=${BAM%_Aligned.MarkDup_Filtered.bam}

java -jar -Xmx8g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
-L chrX \
-I ${BAM} \
-o /u/home/d/dechavez/project-rwayne/Clup/GVCF/TG/${ID}_chrX.g.vcf.gz
