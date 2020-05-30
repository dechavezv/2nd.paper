#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/Clup/reads/BV/Merged
#$ -l h_rt=30:00:00,h_data=14G,highp,h_vmem=40G
#$ -t 32-32:1
#$ -N HC_BV_22
#$ -o /u/home/d/dechavez/project-rwayne/Clup/reads/BV/Merged/log/reports
#$ -e /u/home/d/dechavez/project-rwayne/Clup/reads/BV/Merged/log/reports
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/home/d/dechavez/project-rwayne/Clup/reads/BV/Merged

export BAM=$(ls Reheader_Merged_ClupSRR79764$(printf %02d $SGE_TASK_ID)_*Aligned.MarkDup_Filtered.bam)
export ID=${BAM%_Aligned.MarkDup_Filtered.bam}

java -jar -Xmx14g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
-L chr22 \
-I ${BAM} \
-o /u/home/d/dechavez/project-rwayne/Clup/reads/BV/GVC/BV/${ID}_chr22.g.vcf.gz
