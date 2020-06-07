#! /bin/bash

#$ -wd  /u/scratch/d/dechavez/SA.VCF/Filtered/20200530
#$ -l highp,h_rt=4:00:00,h_data=1G
#$ -N subROH
#$ -o /u/scratch/d/dechavez/SA.VCF/log/
#$ -e /u/scratch/d/dechavez/SA.VCF/log/
#$ -m abe
#$ -M dechavezv
### #$ -t 1-10:1

SCRIPT_DIR=/u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/ROH
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

cd /u/scratch/d/dechavez/SA.VCF/Filtered/20200530

#Prive a list with name of samples

#for line in $(cat ${SCRIPT_DIR}/list.sp.ROH.Het.txt); do
## ${QSUB} -N ROHstep1 $SCRIPT_DIR/Step1_ROH_VCFtoPLINK.sh ${line}
#done

${QSUB} -N ROHstep1 $SCRIPT_DIR/Step1_ROH_VCFtoPLINK.sh Lculp

sleep 35m

cd plinkInputFiles

# For making temp.txt
## for a in 50 100 200; \
## do for b in 50 100; \
## do for c in 1000 2000 5000; \
## do for d in 50 100 200; \
## do for e in 1 2 3 4 5 10 20; \
## do for f in 1 2 3 4 5 10 20; \
## do for g in .02 .05 .1; \
## do echo $a $b $c $d $e $f $g >> temp.txt ; done; done; done; done; done; done; done

${QSUB} -N ROHstep2 ${SCRIPT_DIR}/Step2_run_PLINK_plot.sh Lculp $(head -n ${SGE_TASK_ID} temp.txt | tail -n 1)

## for line in $(cat ${SCRIPT_DIR}/list.sp.ROH.Het.txt); do
### ${QSUB} -N ROHstep2 ${SCRIPT_DIR}/Step2_run_PLINK_plot.sh ${line} $(head -n ${SGE_TASK_ID} temp.txt | tail -n 1)
## done

