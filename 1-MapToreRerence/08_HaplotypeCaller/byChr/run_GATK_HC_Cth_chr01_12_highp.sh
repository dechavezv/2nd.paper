#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/Cth/reads
#$ -l h_rt=42:00:00,h_data=14G,highp,h_vmem=40G
#$ -N HC_BV_12
#$ -o /u/home/d/dechavez/project-rwayne/Cth/reads/log/reports
#$ -e /u/home/d/dechavez/project-rwayne/Cth/reads/log/reports
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/home/d/dechavez/project-rwayne/Cth/reads

export BAM=bCth_Aligned.MarkDup_Filtered.bam
export ID=${BAM%_Aligned.MarkDup_Filtered.bam}

java -jar -Xmx14g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
-L chr12 \
-I ${BAM} \
-o /u/home/d/dechavez/project-rwayne/Cth/GVCF/${ID}_chr12.g.vcf.gz
