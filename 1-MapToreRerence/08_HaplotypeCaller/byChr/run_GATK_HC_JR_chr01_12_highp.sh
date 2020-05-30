#! /bin/bash
#$ -wd /u/scratch/d/dechavez/NA.Genomes
#$ -l h_rt=42:00:00,h_data=16G,highp,h_vmem=40G
#$ -t 26-43:1
#$ -N HC_NA_Clup_12
#$ -o /u/scratch/d/dechavez/NA.Genomes/log/reports
#$ -e /u/scratch/d/dechavez/NA.Genomes/log/reports
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/scratch/d/dechavez/NA.Genomes

export BAM=$(ls $(printf %02d $SGE_TASK_ID)_IRNP_*Aligned_MarkDuplicates_Filtered.bam)
export ID=${BAM%_Aligned_MarkDuplicates_Filtered.bam}

java -jar -Xmx16g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
-L chr12 \
-I ${BAM} \
-o /u/scratch/d/dechavez/NA.Genomes/${ID}_chr12.g.vcf.gz
