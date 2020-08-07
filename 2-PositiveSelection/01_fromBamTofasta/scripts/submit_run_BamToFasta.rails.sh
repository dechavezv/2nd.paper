#! /bin/bash

#$ -wd /u/scratch/d/dechavez/IndelReal/split.bams
#$ -l h_rt=24:00:00,h_data=1G
#$ -N subBamTofasta
#$ -o /u/scratch/d/dechavez/IndelReal/split.bams/log/
#$ -e /u/scratch/d/dechavez/IndelReal/split.bams/log/
#$ -m abe
#$ -M dechavezv

export SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/01_fromBamTofasta/scripts
export DIREC=/u/scratch/d/dechavez/IndelReal/split.bams
export QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

cd ${DIREC}

### $QSUB run_BamToFasta.sh ${BAM} ${depth_95th}

#for i in {01..38} X; do
###$QSUB ${SCRIPTDIR}/run_BamToFasta.sh CroatianW_Aligned.MarkDup_Filtered.bam_chr${i}.bam  20
#done

for i in {1..35} W; do
$QSUB ${SCRIPTDIR}/run_BamToFasta.sh 01_LS_Aligned.AtlChr.MarkDup_Filtered.bam_chr${i}.bam  81
done

for i in {1..35} W; do
$QSUB ${SCRIPTDIR}/run_BamToFasta.sh 02_LS_Aligned.AtlChr.MarkDup_Filtered.bam_chr${i}.bam  84
done

for i in {1..35} W; do
$QSUB ${SCRIPTDIR}/run_BamToFasta.sh 03_LS_Aligned.AtlChr.MarkDup_Filtered.bam_chr${i}.bam  62
done

for i in {1..35} W; do
$QSUB ${SCRIPTDIR}/run_BamToFasta.sh 04_LS_Aligned.AtlChr.MarkDup_Filtered.bam_chr${i}.bam  51
done

for i in {1..35} W; do
$QSUB ${SCRIPTDIR}/run_BamToFasta.sh 05_LS_Aligned.AtlChr.MarkDup_Filtered.bam_chr${i}.bam  80
done

for i in {1..35} W; do
$QSUB ${SCRIPTDIR}/run_BamToFasta.sh 06_LS_Aligned.AtlChr.MarkDup_Filtered.bam_chr${i}.bam  62
done

for i in {1..35} W; do
$QSUB ${SCRIPTDIR}/run_BamToFasta.sh 07_LS_Aligned.AtlChr.MarkDup_Filtered.bam_chr${i}.bam  52
done

for i in {1..35} W; do
$QSUB ${SCRIPTDIR}/run_BamToFasta.sh 08_LS_Aligned.AtlChr.MarkDup_Filtered.bam_chr${i}.bam  63
done
