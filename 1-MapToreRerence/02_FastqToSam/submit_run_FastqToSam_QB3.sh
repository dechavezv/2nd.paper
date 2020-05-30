#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav
#$ -l highp,h_rt=02:00:00,h_data=1G
#$ -N subfq2sam
#$ -o /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav/log/FastqToSam
#$ -e /u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav/log/FastqToSam
#$ -m abe
#$ -M dechavezv

#highmem

#usage [dir] [read_1] [read_2] [outfile] [RG] [sample] [library] [flowcell] [seq center]

#QSUB=/u/systems/UGE8.0.1vm/bin/lx-amd64/qsub
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/02_FastqToSam/run_FastqToSam_QB3.sh

DIR=/u/home/d/dechavez/project-rwayne/QB3.SA.WolfHeav

#SA canids
${QSUB} ${SCRIPT} ${DIR} bcbr370_S10_R1_001.fastq.gz bcbr370_S10_R2_001.fastq.gz bcbr370_FastqToSam.bam bcbr370 Cbr370 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT} ${DIR} bcbr383_S9_R1_001.fastq.gz bcbr383_S9_R2_001.fastq.gz bcbr383_FastqToSam.bam bcbr383 Cbr383 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT} ${DIR} bcbr388_S12_R1_001.fastq.gz bcbr388_S12_R2_001.fastq.gz bcbr388_FastqToSam.bam bcbr388 Cbr388 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT} ${DIR} bcbr404_S11_R1_001.fastq.gz bcbr404_S11_R2_001.fastq.gz bcbr404_FastqToSam.bam bcbr404 Cbr404 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT} ${DIR} bsve313_S13_R1_001.fastq.gz bsve313_S13_R2_001.fastq.gz bsve313_FastqToSam.bam bsve313 Sve313 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT} ${DIR} bsve315_S14_R1_001.fastq.gz bsve315_S14_R2_001.fastq.gz bsve315_FastqToSam.bam bsve315 Sve315 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT} ${DIR} bsve338_S15_R1_001.fastq.gz bsve338_S15_R2_001.fastq.gz bsve338_FastqToSam.bam bsve338 Sve338 Lib1 H5FTWDSXY UB_QB3

#Wolves
${QSUB} ${SCRIPT} ${DIR} Clup_1_S1_R1_001.fastq.gz Clup_1_S1_R2_001.fastq.gz Clup5558_FastqToSam.bam Clup1 Clup5558 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT} ${DIR} Clup_2f_S2_R1_001.fastq.gz Clup_2f_S2_R2_001.fastq.gz Clup1185_FastqToSam.bam Clup2f Clup1185 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT} ${DIR} Clup_3_S3_R1_001.fastq.gz Clup_3_S3_R2_001.fastq.gz Clup2491_FastqToSam.bam Clu3 Clup2491 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT} ${DIR} Clup_4b_S4_R1_001.fastq.gz Clup_4b_S4_R2_001.fastq.gz Clup5161_FastqToSam.bam Clup4b Clup5161 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT} ${DIR} Clup_5b_S5_R1_001.fastq.gz Clup_5b_S5_R2_001.fastq.gz Clup6459_FastqToSam.bam Clup5b Clup6459 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT} ${DIR} Clup_6b_S6_R1_001.fastq.gz Clup_6b_S6_R2_001.fastq.gz Clup4267_FastqToSam.bam Clup6b Clup4267 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT} ${DIR} Clup_7d_S7_R1_001.fastq.gz Clup_7d_S7_R2_001.fastq.gz Clup1694_FastqToSam.bam Clup7d Clup1694 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT} ${DIR} Clup_8b_S8_R1_001.fastq.gz Clup_8b_S8_R2_001.fastq.gz Clup6338_FastqToSam.bam Clup8b Clup6338 Lib1 H5FTWDSXY UB_QB3
