#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/03-Run_PAML
#$ -l highp,h_rt=36:00:00,h_data=5G
#$ -N subPAML
#$ -o /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/03-Run_PAML/log/PAML
#$ -e /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/03-Run_PAML/log/PAML
#$ -m abe
#$ -M dechavezv

export SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/03-Run_PAML/scripts
export DIREC=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/03-Run_PAML

export QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub


echo '######################################'
echo  Create subdirectories
echo '######################################'

$QSUB ${SCRIPTDIR}/Prepare_to_PALM_SETUP_I_Part_PRANK.sh


#add more time if any step has not been completed
sleep 1m

cd ${DIREC}/Procesing

echo '######################################'
echo  Align sequences as amino acids
echo '######################################'

for dir in dir*; do (cd $dir && $QSUB PAML_aling_PRANK.sh);done

sleep 3m

echo '######################################'
echo  Transform amino acid sequence to nucleotide sequence
echo '######################################'

$QSUB ${SCRIPTDIR}/Create_codon_aminoacid_table.sh

sleep 1m

echo '######################################'
echo  Create enviroment for PAML and run the branch-site model
echo '######################################'

for dir in dir*; do (cd $dir && $QSUB Prepare_to_PALM_SETUP_II_part.sh );done

sleep 36m

echo '######################################'
echo  Create final multispecies sequences and ouput files
echo '######################################'

$QSUB ${SCRIPTDIR}/Create_Output.sh
