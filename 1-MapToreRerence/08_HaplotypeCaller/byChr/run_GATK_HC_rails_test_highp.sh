#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/Clup/reads/BV/Merged
#$ -l h_rt=32:00:00,h_data=4G,highp,h_vmem=6G
#$ -N HC_BV_12
#$ -o /u/home/d/dechavez/project-rwayne/Clup/reads/BV/Merged/log/reports
#$ -e /u/home/d/dechavez/project-rwayne/Clup/reads/BV/Merged/log/reports
#$ -m abe
#$ -M dechavezv

### #$ -t 001-001:1
source /u/local/Modules/default/init/modules.sh
module load java

cd /u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/Split.bams
export REFERENCE=/u/home/d/dechavez/project-rwayne/rails.project/reference.genomes/InaccesibleRail/InaccesibleRail.fa


BAM=LS_397_LS57.FastqToSam.bam_Aligned.MarkDup_Filtered.Reheader2.bam
ID=${BAM%_Aligned.MarkDup_Filtered.bam}

java -jar -Xmx4g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R ${REFERENCE} \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
-I ${BAM} \
-o /u/scratch/d/dechavez/rails.project/bams/Daniel.2020/bam/Split.bams/${ID}.Rehead2..g.vcf.gz
