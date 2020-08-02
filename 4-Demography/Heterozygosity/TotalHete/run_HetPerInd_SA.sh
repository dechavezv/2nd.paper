#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/SA.VCF/Combined
#$ -l highp,h_rt=24:00:00,h_data=1G,arch=intel*
#$ -N SAtotHet
#$ -o /u/home/d/dechavez/project-rwayne/SA.VCF/Combined/log/
#$ -e /u/home/d/dechavez/project-rwayne/SA.VCF/Combined/log/
#$ -m abe
#$ -M dechavezv
#$ -t 1-38:1

# Usage: qsub run_HetPerInd_SA.sh

source /u/local/Modules/default/init/modules.sh
module load python

SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/Heterozygosity/TotalHete

Direc=/u/home/d/dechavez/project-rwayne/SA.VCF/Combined

cd ${Direc}

i=$(printf %02d $SGE_TASK_ID)

python ${SCRIPTDIR}/HetPerInd_SA.py SA_chr${i}_TrimAlt_Annot_Mask_Filter.vcf.gz ${i}

#for i in {01..8}; do (python ${SCRIPTDIR}/HetPerInd_SA.py Reheader_${i}_FastqToSam.bam_Aligned.MarkDup_Filtered_Masked.vcf.gz);done

#for line in $(cat /u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/ROH/list.sp.ROH.Het.txt); do /
#python ${SCRIPTDIR}/HetPerInd_SA.py $(ls ${line}_chr$(printf %02d $SGE_TASK_ID)*vcf.gz) ${SGE_TASK_ID};done

## python ${SCRIPTDIR}/HetPerInd_SA.py $(ls LS01_chr$(printf %02d $SGE_TASK_ID)*.vcf.gz) ${SGE_TASK_ID}                               
python ${SCRIPTDIR}/HetPerInd_SA.py Reheader_$(printf %02d $SGE_TASK_ID)_FastqToSam.bam_Aligned.MarkDup_Filtered_Masked.vcf.gz

