#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/03-Run_PAML
#$ -l highp,h_rt=36:00:00,h_data=1G
#$ -N subPAML
#$ -o /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/03-Run_PAML/log/PAML
#$ -e /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/03-Run_PAML/log/PAML
#$ -m abe
#$ -M dechavezv

SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/03-Run_PAML/scripts
DIREC=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/03-Run_PAML

QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

$QSUB ${SCRIPTDIR}/Prepare_to_PALM_SETUP_I_Part_PRANK.sh

sleep 1h

cd ${DIREC}/Processing

for dir in dir*; do (cd $dir && echo $dir && $QSUB Prepare_to_PALM_SETUP_I_Part_PRANK.sh);done > PAML.Prank.log

sleep 4h

cd ${DIREC}
$QSUB Create_codon_aminoacid_table.sh

sleep 2h

cd ${DIREC}/Processing

for dir in dir*; do (cd $dir && echo $dir && $QSUB Prepare_to_PALM_SETUP_II_part.sh);done > PAML.Prank.log

sleep 4h

$QSUB ${SCRIPTDIR}/Create_Output.sh
