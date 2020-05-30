#! /bin/bash

#$ -wd /u/scratch/d/dechavez/rails.project/VCF/Indv
#$ -l h_rt=24:00:00,h_data=4G,h_vmem=18G,arch=intel*
#$ -t 1-8:1
#$ -N FilterVCFrail
#$ -o /u/scratch/d/dechavez/rails.project/VCF/Indv/log
#$ -e /u/scratch/d/dechavez/rails.project/VCF/Indv/log
#$ -m abe
#$ -M dechavezv

#highmem_forced=TRUE,highp

source /u/local/Modules/default/init/modules.sh
module load java
module load python/2.7

REFERENCE=/u/home/d/dechavez/project-rwayne/rails.project/reference.genomes/InaccesibleRail/chr_and_superScafolds/InaccesibleRail.chr.fa
GATK=/u/local/apps/gatk/3.7/GenomeAnalysisTK.jar

cd /u/scratch/d/dechavez/rails.project/VCF/Indv
export VCF=LS$(printf  %02d $SGE_TASK_ID)_chrW_TrimAlt_Annot.vcf.gz

### VariantFiltration
LOG=${VCF%.vcf.gz}_VariantFiltration.log
date "+%Y-%m-%d %T" > ${LOG}

java -jar -Xmx4g ${GATK} \
-T VariantFiltration \
-R ${REFERENCE} \
-filter "QD < 2.0" -filterName "FAIL_QD" \
-filter "FS > 60.0" -filterName "FAIL_FS" \
-filter "MQ < 40.0" -filterName "FAIL_MQ" \
-filter "MQRankSum < -12.5" -filterName "FAIL_MQRankSum" \
-filter "ReadPosRankSum < -8.0" -filterName "FAIL_ReadPosRankSum" \
-filter "ReadPosRankSum > 8.0" -filterName "FAIL_ReadPosRankSum" \
-filter "SOR > 4.0" -filterName "FAIL_SOR" \
-l ERROR \
-V ${VCF} \
-o ${VCF%.vcf.gz}_Mask.vcf.gz &>> ${LOG}


exitVal=${?}
if [ ${exitVal} -ne 0 ]; then
	echo -e "FAILED SelectVariants" >> ${LOG}
	exit
fi
date "+%Y-%m-%d %T" >> ${LOG}

### Custom filtering

SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/11_FilterVCF/scripts/filterVCF_Rails.py

python2.7 ${SCRIPT} ${VCF%.vcf.gz}_Mask.vcf.gz | /u/home/d/dechavez/tabix-0.2.6/bgzip > ${VCF%.vcf.gz}_Mask_Filter.vcf.gz

/u/home/d/dechavez/tabix-0.2.6/tabix -p vcf ${VCF%.vcf.gz}_Mask_Filter.vcf.gz
