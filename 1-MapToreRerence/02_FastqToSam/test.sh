#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/Clup/reads/BV
#$ -l highmem,highp,h_rt=02:00:00,h_data=1G
#$ -N BV.subfq2sam
#$ -o /u/home/d/dechavez/project-rwayne/Clup/reads/BV/log/FastqToSam
#$ -e /u/home/d/dechavez/project-rwayne/Clup/reads/BV/log/FastqToSam
#$ -m abe
#$ -M dechavezv

#highmem

#usage [dir] [read_1] [read_2] [outfile] [RG] [sample] [library] [flowcell] [seq center]

#QSUB=/u/systems/UGE8.0.1vm/bin/lx-amd64/qsub
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/02_FastqToSam/run_FastqToSam_BV.sh
SCRIPT2=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/02_FastqToSam/run_FastqToSam_BV.Single.sh 

DIR=/u/home/d/dechavez/project-rwayne/Clup/reads/BV

#SA canids
${QSUB} ${SCRIPT} ${DIR} SRR7976407_eastern_wolf_1.fastq.gz SRR7976407_eastern_wolf_2.fastq.gz SRR7976407_eastern_wolf.fastq.gz ClupSRR7976407 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT2} ${DIR} SRR7976408_eastern_wolf.fastq.gz ClupSRR7976408 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT2} ${DIR}  SRR7976410_gray_wolf.fastq.gz ClupSRR7976410 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT} ${DIR} SRR7976417_red_wolf_1.fastq.gz SRR7976417_red_wolf_2.fastq.gz SRR7976417_red_wolf.fastq.gz ClupSRR7976417 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT2} ${DIR} SRR7976418_red_wolf.fastq.gz ClupSRR7976418 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT2} ${DIR} SRR7976419_red_wolf.fastq.gz ClupSRR7976419 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT2} ${DIR} SRR7976420_gray_wolf.fastq.gz ClupSRR7976420 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT} ${DIR} SRR7976421_gray_wolf_1.fastq.gz SRR7976421_gray_wolf_2.fastq.gz SRR7976421_gray_wolf.fastq.gz ClupSRR7976421 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT} ${DIR} SRR7976422_gray_wolf_1.fastq.gz SRR7976422_gray_wolf_2.fastq.gz SRR7976422_gray_wolf.fastq.gz ClupSRR7976422 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT} ${DIR} SRR7976423_gray_wolf_1.fastq.gz SRR7976423_gray_wolf_2.fastq.gz SRR7976423_gray_wolf.fastq.gz ClupSRR7976423 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT2} ${DIR} SRR7976424_gray_wolf.fastq.gz ClupSRR7976424 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT} ${DIR} SRR7976425_gray_wolf_1.fastq.gz SRR7976425_gray_wolf_2.fastq.gz SRR7976425_gray_wolf.fastq.gz ClupSRR7976425 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT} ${DIR} SRR7976431_Mexican_wolf_1.fastq.gz SRR7976431_Mexican_wolf_2.fastq.gz SRR7976431_Mexican_wolf.fastq.gz ClupSRR7976431 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT} ${DIR} SRR7976432_gray_wolf_1.fastq.gz SRR7976432_gray_wolf_2.fastq.gz SRR7976432_gray_wolf.fastq.gz ClupSRR7976432 Lib1 H5FTWDSXY UB_QB3
