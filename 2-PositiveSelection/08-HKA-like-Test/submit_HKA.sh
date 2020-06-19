#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/Lvet
#$ -l highp,h_rt=14:00:00,h_data=1G
#$ -N runHKA
#$ -o /u/scratch/d/dechavez/HKA/log/
#$ -e /u/scratch/d/dechavez/HKA/log/
#$ -m abe
#$ -M dechavezv

SCRIPT_DIR=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/08-HKA-like-Test

source /u/local/Modules/default/init/modules.sh
module load java
module load python/2.7

cd /u/scratch/d/dechavez/HKA

for i in {01..38} X; do ( echo chr$i && \
python ${SCRIPT_DIR}/SlidWin-HKA-like-Test.py bsve_joint_chr${i}_Annot_Mask_Filter.vcf.gz \
100000 10000 chr${i} > bsve_joint_chr${i}_Annot_Mask_Filter_passingSNPs.HKA.txt);done
