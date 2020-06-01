#! /bin/bash

#$ -l highp,h_rt=4:00:00,h_data=1G
#$ -N SUBmsmsc
#$ -o /u/scratch/d/dechavez/SA.VCF/log/
#$ -e /u/scratch/d/dechavez/SA.VCF/log/
#$ -m abe
#$ -M dechavezv

SCRIPT_DIR=/u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/msmc
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

cd /u/scratch/d/dechavez/SA.VCF/Filtered/20200530


${QSUB} -N OnlyPassVCF $SCRIPT_DIR/Step_2_runMSMC.SA.canids.sh Sve338

${QSUB} -N OnlyPassVCF $SCRIPT_DIR/Step_2_runMSMC.SA.canids.sh Sve315

${QSUB} -N OnlyPassVCF $SCRIPT_DIR/Step_2_runMSMC.SA.canids.sh Sve313

${QSUB} -N OnlyPassVCF $SCRIPT_DIR/Step_2_runMSMC.SA.canids.sh Cbr404

${QSUB} -N OnlyPassVCF $SCRIPT_DIR/Step_2_runMSMC.SA.canids.sh Cbr388

${QSUB} -N OnlyPassVCF $SCRIPT_DIR/Step_2_runMSMC.SA.canids.sh Cbr383

${QSUB} -N OnlyPassVCF $SCRIPT_DIR/Step_2_runMSMC.SA.canids.sh Cbr370
