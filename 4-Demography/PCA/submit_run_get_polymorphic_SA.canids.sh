#! /bin/bash

#$ -wd /u/scratch/d/dechavez/SA.VCF/Filtered/20200530
#$ -l highp,h_rt=4:00:00,h_data=1G
#$ -N subSNPonly
#$ -o /u/scratch/d/dechavez/SA.VCF/log/reportsfilter.out
#$ -e /u/scratch/d/dechavez/SA.VCF/log/reportsfilter.err
#$ -m abe
#$ -M dechavezv

SCRIPT_DIR=/u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/PCA
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

cd /u/scratch/d/dechavez/SA.VCF/Filtered/20200530

#for line in $(cat /u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/ROH/list.sp.ROH.Het.txt); do (echo $line && \
#for i in {01..38}; do (${QSUB} -N OnlyPassVCF $SCRIPT_DIR/run_get_polymorphic_SA.canids.sh ${line} ${i});done);done

for i in {01..38} X; do
${QSUB} -N OnlyPassVCF $SCRIPT_DIR/run_get_polymorphic_SA.canids.sh bsve_joint $i;done

## for i in {01..38}; do
## ${QSUB} -N OnlyPassVCF $SCRIPT_DIR/run_get_polymorphic_SA.canids.sh bcbr05 $i;done

## for i in {01..38}; do
## ${QSUB} -N OnlyPassVCF $SCRIPT_DIR/run_get_polymorphic_SA.canids.sh Lgy01 $i;done

## for i in {01..38}; do
## ${QSUB} -N OnlyPassVCF $SCRIPT_DIR/run_get_polymorphic_SA.canids.sh Csmi01 $i;done

## for i in {01..38}; do
## ${QSUB} -N OnlyPassVCF $SCRIPT_DIR/run_get_polymorphic_SA.canids.sh bsve04 $i;done

## for i in {01..38}; do
## ${QSUB} -N OnlyPassVCF $SCRIPT_DIR/run_get_polymorphic_SA.canids.sh Lve01 $i;done

## for i in {01..38}; do
## ${QSUB} -N OnlyPassVCF $SCRIPT_DIR/run_get_polymorphic_SA.canids.sh Lculp01 $i;done

## for i in {01..38}; do
## ${QSUB} -N OnlyPassVCF $SCRIPT_DIR/run_get_polymorphic_SA.canids.sh SV16082018 $i;done
