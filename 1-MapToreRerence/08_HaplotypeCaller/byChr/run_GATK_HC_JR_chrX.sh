#! /bin/bash
#$ -wd /u/scratch/d/dechavez/NA.Genomes
#$ -l h_rt=32:00:00,h_data=16G,highp,h_vmem=40G
#$ -t 26-43:1
#$ -N HC_NA_ClupX
#$ -o /u/scratch/d/dechavez/NA.Genomes/log/reports.X
#$ -e /u/scratch/d/dechavez/NA.Genomes/log/reports.X
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/scratch/d/dechavez/NA.Genomes

export BAM=$(ls $(printf %02d $SGE_TASK_ID)_IRNP_*Aligned_MarkDuplicates_Filtered.bam)
export ID=${BAM%_Aligned.MarkDup_Filtered.bam}

java -jar -Xmx16g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
-L chrX \
-I ${BAM} \
-o /u/scratch/d/dechavez/NA.Genomes/${ID}_chrX.g.vcf.gz
