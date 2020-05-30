#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav/Bams.Filtered
#$ -l highmem,highp,h_rt=44:00:00,h_data=36G,arch=intel*
#$ -N HC_BD_allChr
#$ -o /u/scratch/d/dechavez/BD/GVCFs/log/HC_BD_Chr01.bsve313
#$ -e /u/scratch/d/dechavez/BD/GVCFs/log/HC_BD_Chr01.bsve313 
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav/Bams.Filtered

export BAM=bsve313_Aligned.MarkDup_Filtered.bam
export ID=bsve313

java -jar -Xmx26g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
-L chrX \
-I ${BAM} \
-o /u/scratch/d/dechavez/BD/GVCFs/${ID}_chrX.g.vcf.gz
