#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/01_fromBamTofasta
#$ -l highp,h_rt=36:00:00,h_data=5G
#$ -N subPAML
#$ -o /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/01_fromBamTofasta/log/BamToFasta
#$ -e /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/01_fromBamTofasta/log/BamToFasta
#$ -m abe
#$ -M dechavezv

export SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/01_fromBamTofasta/scripts
export DIREC=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/01_fromBamTofasta
export QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
export depth.95th=70
export spescies=red.fox

echo '######################################'
echo  OPTION 1: WHOLE GENOME
echo '######################################'

$QSUB ${SCRIPTDIR}/from_AlignedBam_To_Fasta_byChr.sh ${depth.95th} ${spescies} 


# Run the next command ONLY if you have split your bam

#echo '######################################'
#echo  OPTION 2: BY CHROMOSOME
#echo '######################################'

#for i in {01..38} X MT; do (cd $dir && $QSUB from_AlignedBam_To_Fasta_byChr.sh chr$i ${depth.95th} ${spescies} );done

