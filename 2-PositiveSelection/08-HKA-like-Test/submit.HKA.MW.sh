#! /bin/bash

#$ -wd /u/scratch/d/dechavez/HKA/
#$ -l highp,h_rt=14:00:00,h_data=1G
#$ -N SubRunHKA.MW
#$ -o /u/scratch/d/dechavez/HKA/log/
#$ -e /u/scratch/d/dechavez/HKA/log/
#$ -m abe
#$ -M dechavezv


SCRIPT_DIR=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/08-HKA-like-Test
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

${QSUB} ${SCRIPT_DIR}/calcualte.HKA.MW.sh 
${QSUB} ${SCRIPT_DIR}/calcualte.HKA.MW.X.sh

sleep 15min

cd /u/scratch/d/dechavez/HKA/MW

echo '********** Getting the final table ***********'
echo -e 'chrom\tStarWind\tEndWind\tHKAratio\tTotalSites\tGoodQsites\tPercGoodQ\tENSEMBL\tGene' > HKA.MW.June20.txt
for i in {01..38} X;do \
cat Genes_HKA_bcbr_joint_chr${i}_TrimAlt_Annot_Mask_Filter.HKA.txt | sort -k2,3 -h | uniq >> HKA.MW.June20.txt;done

sleep 10min

rm Genes*
rm *HKA.txt
