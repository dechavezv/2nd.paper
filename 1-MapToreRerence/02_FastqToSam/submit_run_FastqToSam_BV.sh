#! /bin/bash
#$ -wd /u/scratch/d/dechavez/YNP_4Genomes
#$ -l highp,h_rt=02:00:00,h_data=1G
#$ -N subfq2sam
#$ -o /u/scratch/d/dechavez/YNP_4Genomes/log/FastqToSam
#$ -e /u/scratch/d/dechavez/YNP_4Genomes/log/FastqToSam
#$ -m abe
#$ -M dechavezv

#highmem

#usage [dir] [read_1] [read_2] [outfile] [RG] [sample] [library] [flowcell] [seq center]

QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/02_FastqToSam/run_FastqToSam_BV.sh
#SCRIPT2=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/02_FastqToSam/run_FastqToSam_BV.Single.sh 

DIR=/u/scratch/d/dechavez/YNP_4Genomes

#SA canids

${QSUB} ${SCRIPT} ${DIR} RSRW022_S21_L005_R1_001.fastq.gz RSRW022_S21_L005_R2_001.fastq.gz ClupRKW3624_629M_YNP.paired.bam ClupRKW3624 Lib1 H3NK3BBXX Minesota

${QSUB} ${SCRIPT} ${DIR} RSRW023_S22_L006_R1_001.fastq.gz RSRW023_S22_L006_R2_001.fastq.gz ClupRKW3637_645F_YNP.paired.bam ClupRKW3637 Lib1 H3NK3BBXX Minesota

${QSUB} ${SCRIPT} ${DIR} RSRW024_S23_L007_R1_001.fastq.gz RSRW024_S23_L007_R2_001.fastq.gz ClupRKW7526_694F_YNP.paired.bam ClupRKW7526 Lib1 H3NK3BBXX Minesota

## ${QSUB} ${SCRIPT} ${DIR} SRR7976407_eastern_wolf_1.fastq.gz SRR7976407_eastern_wolf_2.fastq.gz ClupSRR7976407_eastern_wolf.paired.bam ClupSRR7976407 Lib1 H5FTWDSXY UB_QB3

## ${QSUB} ${SCRIPT2} ${DIR} SRR7976407_eastern_wolf.fastq.gz ClupSRR7976407_eastern_wolf.single.bam ClupSRR7976407 Lib1 H5FTWDSXY UB_QB3

##${QSUB} ${SCRIPT2} ${DIR} SRR7976408_eastern_wolf.fastq.gz ClupSRR7976408_eastern_wolf.single.bam ClupSRR7976408 Lib1 H5FTWDSXY UB_QB3

## ${QSUB} ${SCRIPT2} ${DIR}  SRR7976410_gray_wolf.fastq.gz ClupSRR7976410_gray_wolf.single.bam ClupSRR7976410 Lib1 H5FTWDSXY UB_QB3

## ${QSUB} ${SCRIPT} ${DIR} SRR7976417_red_wolf_1.fastq.gz SRR7976417_red_wolf_2.fastq.gz ClupSRR7976417_red_wolf.paired.bam ClupSRR7976417 Lib1 H5FTWDSXY UB_QB3

## ${QSUB} ${SCRIPT2} ${DIR} SRR7976417_red_wolf.fastq.gz ClupSRR7976417_red_wolf.single.bam ClupSRR7976417 Lib1 H5FTWDSXY UB_QB3

## ${QSUB} ${SCRIPT2} ${DIR} SRR7976418_red_wolf.fastq.gz ClupSRR7976418_red_wolf.single.bam ClupSRR7976418 Lib1 H5FTWDSXY UB_QB3

## ${QSUB} ${SCRIPT2} ${DIR} SRR7976419_red_wolf.fastq.gz ClupSRR7976419_red_wolf.single.bam ClupSRR7976419 Lib1 H5FTWDSXY UB_QB3

## ${QSUB} ${SCRIPT2} ${DIR} SRR7976420_gray_wolf.fastq.gz ClupSRR7976420_gray_wolf.single.bam ClupSRR7976420 Lib1 H5FTWDSXY UB_QB3

## ${QSUB} ${SCRIPT} ${DIR} SRR7976421_gray_wolf_1.fastq.gz SRR7976421_gray_wolf_2.fastq.gz ClupSRR7976421_gray_wolf.paired.bam ClupSRR7976421 Lib1 H5FTWDSXY UB_QB3

## ${QSUB} ${SCRIPT2} ${DIR} SRR7976421_gray_wolf.fastq.gz ClupSRR7976421_gray_wolf.single.bam ClupSRR7976421 Lib1 H5FTWDSXY UB_QB3

## ${QSUB} ${SCRIPT} ${DIR} SRR7976422_gray_wolf_1.fastq.gz SRR7976422_gray_wolf_2.fastq.gz ClupSRR7976422_gray_wolf.paired.bam SRR7976422 Lib1 H5FTWDSXY UB_QB3 

## ${QSUB} ${SCRIPT2} ${DIR} SRR7976422_gray_wolf.fastq.gz ClupSRR7976422_gray_wolf.single.bam ClupSRR7976422 Lib1 H5FTWDSXY UB_QB3

## ${QSUB} ${SCRIPT} ${DIR} SRR7976423_gray_wolf_1.fastq.gz SRR7976423_gray_wolf_2.fastq.gz ClupSRR7976423_gray_wolf.paired.bam SRR7976423 Lib1 H5FTWDSXY UB_QB3

## ${QSUB} ${SCRIPT2} ${DIR} SRR7976423_gray_wolf.fastq.gz ClupSRR7976423_gray_wolf.single.bam ClupSRR7976423 Lib1 H5FTWDSXY UB_QB3

## ${QSUB} ${SCRIPT2} ${DIR} SRR7976424_gray_wolf.fastq.gz ClupSRR7976424_gray_wolf.single.bam ClupSRR7976424 Lib1 H5FTWDSXY UB_QB3

## ${QSUB} ${SCRIPT} ${DIR} SRR7976425_gray_wolf_1.fastq.gz SRR7976425_gray_wolf_2.fastq.gz ClupSRR7976425_gray_wolf.paired.bam ClupSRR7976425 Lib1 H5FTWDSXY UB_QB3

## ${QSUB} ${SCRIPT2} ${DIR} SRR7976425_gray_wolf.fastq.gz ClupSRR7976425_gray_wolf.single.bam ClupSRR7976425 Lib1 H5FTWDSXY UB_QB3

## ${QSUB} ${SCRIPT} ${DIR} SRR7976431_Mexican_wolf_1.fastq.gz SRR7976431_Mexican_wolf_2.fastq.gz ClupSRR7976431_Mexican_wolf.paired.bam ClupSRR797643 Lib1 H5FTWDSXY UB_QB3

## ${QSUB} ${SCRIPT2} ${DIR} SRR7976431_Mexican_wolf.fastq.gz ClupSRR7976431_Mexican_wolf.single.bam ClupSRR7976431 Lib1 H5FTWDSXY UB_QB3

## ${QSUB} ${SCRIPT} ${DIR} SRR7976432_gray_wolf_1.fastq.gz SRR7976432_gray_wolf_2.fastq.gz ClupSRR7976432_gray_wolf.paired.bam SRR7976432 Lib1 H5FTWDSXY UB_QB3

## ${QSUB} ${SCRIPT2} ${DIR} SRR7976432_gray_wolf.fastq.gz ClupSRR7976432_gray_wolf.single.bam ClupSRR7976432 Lib1 H5FTWDSXY UB_QB3
