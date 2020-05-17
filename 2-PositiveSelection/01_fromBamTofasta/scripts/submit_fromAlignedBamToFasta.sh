#! /bin/bash

#$ -wd /u/scratch/d/dechavez/IndelReal/split.bams
#$ -l highp,h_rt=36:00:00,h_data=5G
#$ -N subBamTofasta
#$ -o /u/scratch/d/dechavez/IndelReal/split.bams/log/BamToFasta
#$ -e /u/scratch/d/dechavez/IndelReal/split.bams/log/BamToFasta
#$ -m abe
#$ -M dechavezv

export SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/01_fromBamTofasta/scripts
export DIREC=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/01_fromBamTofasta
export QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
#export depth_95th=70
#export spescies=red.fox

echo '######################################'
echo  OPTION 1: WHOLE GENOME
echo '######################################'
### $QSUB ${SCRIPTDIR}/from_AlignedBam_To_Fasta.sh ${depth_95th} ${spescies} 



# Run the next command ONLY if you have split your bam

#echo '######################################'
#echo  OPTION 2: BY CHROMOSOME
#echo '######################################'
for i in {01..38} X MT
do (cd $dir && \
$QSUB from_AlignedBam_To_Fasta_byChr.sh chr$i ${depth_95th} ${spescies} );done
