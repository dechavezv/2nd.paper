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

for i in {01..38}; do 
${QSUB} -N OnlyPassVCF $SCRIPT_DIR/Step_1_PrepMSMCMAGIC.concise.SA.canids.sh Sve338 $i
done

for i in {01..38}; do
${QSUB} -N OnlyPassVCF $SCRIPT_DIR/Step_1_PrepMSMCMAGIC.concise.SA.canids.sh Sve315 $i
done

for i in {01..38}; do
${QSUB} -N OnlyPassVCF $SCRIPT_DIR/Step_1_PrepMSMCMAGIC.concise.SA.canids.sh Sve313 $i
done

for i in {01..38}; do
${QSUB} -N OnlyPassVCF $SCRIPT_DIR/Step_1_PrepMSMCMAGIC.concise.SA.canids.sh Cbr404 $i
done

for i in {01..38}; do
${QSUB} -N OnlyPassVCF $SCRIPT_DIR/Step_1_PrepMSMCMAGIC.concise.SA.canids.sh Cbr388 $i
done

for i in {01..38}; do
${QSUB} -N OnlyPassVCF $SCRIPT_DIR/Step_1_PrepMSMCMAGIC.concise.SA.canids.sh Cbr383 $i
done

for i in {01..38}; do
${QSUB} -N OnlyPassVCF $SCRIPT_DIR/Step_1_PrepMSMCMAGIC.concise.SA.canids.sh Cbr370 $i
done
