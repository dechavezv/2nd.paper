#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/rails.project/reads/Daniel.data.2020
#$ -l h_rt=24:00:00,h_data=8G,h_vmem=40G,arch=intel*
#$ -t 01-8:1
#$ -N HC_rail_sex
#$ -o /u/home/d/dechavez/project-rwayne/rails.project/reads/Daniel.data.2020/log/reports
#$ -e /u/home/d/dechavez/project-rwayne/rails.project/reads/Daniel.data.2020/log/reports
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/home/d/dechavez/project-rwayne/rails.project/reads/Daniel.data.2020

i=Z

export BAM=$(ls $(printf %02d $SGE_TASK_ID)_LS_Aligned.AtlChr.MarkDup_Filtered.bam)
export ID=${BAM%_Aligned.AtlChr.MarkDup_Filtered.bam}

java -jar -Xmx8g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/d/dechavez/project-rwayne/rails.project/reference.genomes/InaccesibleRail/chr_and_superScafolds/InaccesibleRail.chr.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
-L PseudoChr_${i} \
-I ${BAM} \
-o /u/scratch/d/dechavez/rails.project/gvcf/${ID}_chr${i}.g.vcf.gz
