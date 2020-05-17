#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/dire.wolf
#$ -l highp,h_rt=4:00:00,h_data=1G
#$ -N subBamTofasta
#$ -o /u/home/d/dechavez/project-rwayne/dire.wolf/log/BamToFasta
#$ -e /u/home/d/dechavez/project-rwayne/dire.wolf/log/BamToFasta
#$ -m abe
#$ -M dechavezv

export SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/01_fromBamTofasta/scripts
export DIREC=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/01_fromBamTofasta
export QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

cd ${DIREC}
### $QSUB run_BamToFasta.sh ${BAM} ${depth_95th}

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
## $QSUB ${SCRIPTDIR}/run_BamToFasta.sh Cb17082018_rmdup_realign_fixmate_Filtered.bam_chr${i}.bam 78
## done

## for i in {01..38} X; do 
## $QSUB ${SCRIPTDIR}/run_BamToFasta.sh SV16082018_Aligned.MarkDup_Filtered_Indelreal.bam_chr${i}.bam 78
## done

## for i in {01..38} X; do
## $QSUB ${SCRIPTDIR}/run_BamToFasta.sh bCth_Aligned.MarkDup_Filtered_Indelreal.bam_chr${i}.bam 47
## done

$QSUB ${SCRIPTDIR}/run_BamToFasta.sh bCth_Aligned.MarkDup_Filtered_Indelreal_chrX.bam 47
