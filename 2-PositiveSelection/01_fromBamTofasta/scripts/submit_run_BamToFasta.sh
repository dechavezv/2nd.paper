#! /bin/bash

#$ -wd /u/scratch/d/dechavez/IndelReal/split.bams
#$ -l highp,h_rt=4:00:00,h_data=1G
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

for i in {01..38} X; do
$QSUB ${SCRIPTDIR}/01_IRNP_RKW2455_Aligned_MarkDup_Filtered.bam_chr${i}.bam 50
done

for i in {01..38} X; do
$QSUB ${SCRIPTDIR}/run_BamToFasta.sh 22_IRNP_MEX_GR6_Aligned_MarkDup_Filtered.bam_chr${i}.bam  48
done

for i in {01..38} X; do
$QSUB ${SCRIPTDIR}/run_BamToFasta.sh Cla15379Quebec.FastqToSam.bam_Aligned.MarkDup_Filtered.bam_chr${i}.bam 15
done

for i in {01..38} X; do
$QSUB ${SCRIPTDIR}/run_BamToFasta.sh Cla1850Florida.FastqToSam.bam_Aligned.MarkDup_Filtered.bam_chr${i}.bam  16
done

#for i in {01..38} X; do
## $QSUB ${SCRIPTDIR}/run_BamToFasta.sh BBJ_BWA_sortRG_rmdup_realign_fixmate_Filtered.bam_chr${i}.bam 114
#done

#for i in {01..38} X; do
## $QSUB ${SCRIPTDIR}/run_BamToFasta.sh CL100060195_L02_S2_BWA_sortRG_rmdup_realign_fixmate_Filtered.bam_chr${i}.bam 80
#done

#for i in {01..38} X; do
###$QSUB ${SCRIPTDIR}/run_BamToFasta.sh BAM-RMDUP_ACAD1735.bam_chr${i}.bam 20
#done

#for i in {01..38} X; do
###$QSUB ${SCRIPTDIR}/run_BamToFasta.sh BAM-RMDUP_ACAD18742.bam_chr${i}.bam 20
#done

## for i in {01..38} X; do
## $QSUB ${SCRIPTDIR}/run_BamToFasta.sh bcbr01_Aligned.MarkDup_Filtered_Indelreal.bam_chr${i}.bam 49
## done

## for i in {01..38} X; do 
## $QSUB ${SCRIPTDIR}/run_BamToFasta.sh bcbr02_Aligned.MarkDup_Filtered_Indelreal.bam_chr${i}.bam 49
## done

## for i in {01..38} X; do 
## $QSUB ${SCRIPTDIR}/run_BamToFasta.sh bcbr03_Aligned.MarkDup_Filtered_Indelreal.bam_chr${i}.bam 39
## done

## for i in {01..38} X; do 
## $QSUB ${SCRIPTDIR}/run_BamToFasta.sh bcbr04_Aligned.MarkDup_Filtered_Indelreal.bam_chr${i}.bam 43
## done

## for i in {01..38} X; do 
## $QSUB ${SCRIPTDIR}/run_BamToFasta.sh bPgy20_Aligned.MarkDup_Filtered_Indelreal.bam_chr${i}.bam 26
## done

## for i in {01..38} X; do 
## $QSUB ${SCRIPTDIR}/run_BamToFasta.sh bPve20_Aligned.MarkDup_Filtered_Indelreal.bam_chr${i}.bam 67
## done

## for i in {01..38} X; do 
## $QSUB ${SCRIPTDIR}/run_BamToFasta.sh bsve313_Aligned.MarkDup_Filtered_Indelreal.bam_chr${i}.bam 122
## done

## for i in {01..38} X; do 
## $QSUB ${SCRIPTDIR}/run_BamToFasta.sh bsve315_Aligned.MarkDup_Filtered_Indelreal.bam_chr${i}.bam 36
## done

## for i in {01..38} X; do 
## $QSUB ${SCRIPTDIR}/run_BamToFasta.sh bsve338_Aligned.MarkDup_Filtered_Indelreal.bam_chr${i}.bam 42
## done

## for i in {01..38} X; do 
## $QSUB ${SCRIPTDIR}/run_BamToFasta.sh Cb17082018_rmdup_realign_fixmate_Filtered.bam_chr${i}.bam 178
##done

## for i in {01..38} X; do 
## $QSUB ${SCRIPTDIR}/run_BamToFasta.sh SV16082018_Aligned.MarkDup_Filtered_Indelreal.bam_chr${i}.bam 78
## done

## for i in {01..38} X; do
## $QSUB ${SCRIPTDIR}/run_BamToFasta.sh bCth_Aligned.MarkDup_Filtered_Indelreal.bam_chr${i}.bam 47
## done


### $QSUB ${SCRIPTDIR}/run_BamToFasta.sh bCth_Aligned.MarkDup_Filtered_Indelreal_chrX.bam 47
