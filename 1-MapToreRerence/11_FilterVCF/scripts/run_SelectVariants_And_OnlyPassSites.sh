#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/BD/VCF/ROH
#$ -l highmem_forced=TRUE,highp=TRUE,h_rt=13:00:00,h_data=7G,h_vmem=30G
#$ -N runSelectVarVCF
#$ -o /u/home/d/dechavez/project-rwayne/BD/VCF/ROH/log/ROH.reports/
#$ -e /u/home/d/dechavez/project-rwayne/BD/VCF/ROH/log/ROH.reports/
#$ -m abe
#$ -M dechavezv
#$ -t 25-38:1

#highmem_forced=TRUE

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/local/apps/gatk/3.7/GenomeAnalysisTK.jar
REFERENCE=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa
DireVCF=/u/home/d/dechavez/project-rwayne/BD/VCF

cd /u/home/d/dechavez/project-rwayne/BD/VCF/ROH

export INPUT=bsve_joint_chr$(printf %02d ${SGE_TASK_ID})_TrimAlt_Annot_Mask_Filter.vcf.gz
export SAMPLES=$1
export tabix=/u/home/d/dechavez/tabix-0.2.6

java -jar -Xmx4g ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-V ${DireVCF}/${INPUT} \
-o ${INPUT%.vcf.gz}_${SAMPLES%.txt}.vcf.gz \
--sample_file ${SAMPLES} \
-keepOriginalAC -keepOriginalDP

echo '**************Getting Only PAssed sites from chr'$i' *********************'

zcat ${INPUT%.vcf.gz}_${SAMPLES%.txt}.vcf.gz | grep -v 'FAIL' | ${tabix}/bgzip -c \
> ${INPUT%.vcf.gz}_${SAMPLES%.txt}.OnlyPass.vcf.gz

${tabix}/tabix -p vcf ${INPUT%.vcf.gz}_${SAMPLES%.txt}.OnlyPass.vcf.gz

echo '************** Done getting sites with Good Quality from chr$i **********'
