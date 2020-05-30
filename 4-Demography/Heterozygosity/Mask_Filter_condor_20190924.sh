#! /bin/bash
#$ -cwd
#$ -l h_rt=48:00:00,mem_free=20G
#$ -o /wynton/home/walllab/robinsonj/project/reports/condor/MaskFilter
#$ -e /wynton/home/walllab/robinsonj/project/reports/condor/MaskFilter
#$ -N MaskFilterVCF
#$ -t 1-542:1


source /wynton/home/walllab/robinsonj/anaconda3/etc/profile.d/conda.sh
conda activate gentools2

set -o pipefail

REFDIR=/wynton/home/walllab/robinsonj/project/condor/reference/gc_PacBio_HiC
REFERENCE=gc_PacBio_HiC.fasta

REPEATMASK=/wynton/home/walllab/robinsonj/project/condor/reference/gc_PacBio_HiC/gc_PacBio_HiC_repeats.bed

IDX=$(printf %03d ${SGE_TASK_ID})
VCF=$(ls *_${IDX}_*.vcf.gz)


### VariantFiltration
LOG=${VCF%.vcf.gz}_VariantFiltration_${IDX}.log
date "+%Y-%m-%d %T" > ${LOG}

gatk3 -Xmx16g -Djava.io.tmpdir=${TMPDIR} \
-T VariantFiltration \
-R ${REFDIR}/${REFERENCE} \
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

SCRIPT=/wynton/home/walllab/robinsonj/project/scripts/WGSpipeline/condor/filterVCF_condor_20190924.py

python2.7 ${SCRIPT} ${VCF%.vcf.gz}_Mask.vcf.gz | bgzip > ${VCF%.vcf.gz}_Mask_Filter.vcf.gz

tabix -p vcf ${VCF%.vcf.gz}_Mask_Filter.vcf.gz


