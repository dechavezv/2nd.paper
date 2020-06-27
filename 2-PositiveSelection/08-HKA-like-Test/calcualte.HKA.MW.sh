#! /bin/bash

#$ -wd /u/scratch/d/dechavez/HKA
#$ -l h_rt=14:00:00,h_data=1G
#$ -N runHKA.MW
#$ -o /u/scratch/d/dechavez/HKA/log/
#$ -e /u/scratch/d/dechavez/HKA/log/
#$ -m abe
#$ -M dechavezv
#$ -t 1-38:1

i=$(printf "%02d" "$SGE_TASK_ID")
#i=X

SCRIPT_DIR=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/08-HKA-like-Test
OrtoBed=/u/home/d/dechavez/project-rwayne/Besd_Files/Canis_familiaris_all.bed

source /u/local/Modules/default/init/modules.sh
module load java
module load python/2.7

cd /u/scratch/d/dechavez/HKA/MW

echo '********** Conducting HKA per window ***********' 
python ${SCRIPT_DIR}/SlidWin-HKA-like-Test.MW.py bcbr_joint_chr${i}_TrimAlt_Annot_Mask_Filter.vcf.gz \
100000 10000 chr${i} > bcbr_joint_chr${i}_TrimAlt_Annot_Mask_Filter.HKA.txt
echo '********** Done calculating HKA-like test ***********'

echo '********** Extracting genes within windows ***********'
python ${SCRIPT_DIR}/Genes_within_HKA.py bcbr_joint_chr${i}_TrimAlt_Annot_Mask_Filter.HKA.txt ${OrtoBed}
echo '********** Done Extracting genes within windows ***********'
