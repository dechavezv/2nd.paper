#! /bin/bash
#$ -wd /u/scratch/j/jarobins/irnp/bams/
#$ -l h_rt=12:30:00,h_data=1G
#$ -pe shared 12
#$ -N subBQSRs3
#$ -o /u/scratch/j/jarobins/irnp/reports
#$ -e /u/scratch/j/jarobins/irnp/reports
#$ -m abe
#$ -M jarobins

# Step 3: recalibrate BAM
# NOTE: Need to carefully manage disk space usage!!!

QSUB=/u/systems/UGE8.0.1vm/bin/lx-amd64/qsub

SCRIPTDIR=/u/project/mcdb/rwayne/jarobins/utils/scripts/bam_processing/6_BQSR

cd /u/scratch/j/jarobins/irnp/bams/ReadsFiltered

for i in 21 22 23 24 25 26 28; do
	IN_FILE=$(ls ${i}*.bam)
	${QSUB} ${SCRIPTDIR}/run_BQSR_step3_recalibratebam_010817.sh ${IN_FILE}
	sleep 2h
done
