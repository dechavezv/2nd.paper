#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/BD/VCF
#$ -l highp,h_rt=24:00:00,h_data=18G,arch=intel*,h_vmem=30G
#$ -N Filter.VCF.custom.python
#$ -o /u/home/d/dechavez/project-rwayne/BD/VCF
#$ -e /u/home/d/dechavez/project-rwayne/BD/VCF
#$ -m abe
#$ -M dechavezv
#$ -t 37-37:1

#highmem_forced=TRUE,highp

source /u/local/Modules/default/init/modules.sh
module load java
module load python/2.7

REFERENCE=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa

REPEATMASK=/u/home/d/dechavez/project-rwayne/Besd_Files/CpG_and_repeat_filter_cf31_fixed_sorted.bed

GATK=/u/local/apps/gatk/3.7/GenomeAnalysisTK.jar

cd /u/home/d/dechavez/project-rwayne/BD/VCF

IDX=$(printf %02d ${SGE_TASK_ID})
#VCF=$(ls *_chr${IDX}_*TrimAlt_Annot.vcf.gz)
VCF=bsve04_chr${IDX}.vcf.gz

### VariantFiltration
LOG=${VCF%.vcf.gz}_VariantFiltration_${IDX}.log
date "+%Y-%m-%d %T" > ${LOG}

java -jar -Xmx18g ${GATK} \
-T VariantFiltration \
-R ${REFERENCE} \
-mask ${REPEATMASK} -maskName "FAIL_Rep" \
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

SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/11_FilterVCF/scripts/filterVCF_BD.py

python2.7 ${SCRIPT} ${VCF%.vcf.gz}_Mask.vcf.gz | /u/home/d/dechavez/tabix-0.2.6/bgzip > ${VCF%.vcf.gz}_Mask_Filter.vcf.gz

/u/home/d/dechavez/tabix-0.2.6/tabix -p vcf ${VCF%.vcf.gz}_Mask_Filter.vcf.gz
