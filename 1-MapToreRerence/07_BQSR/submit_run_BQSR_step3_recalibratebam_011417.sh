#! /bin/bash
#$ -wd /u/scratch/j/jarobins/irnp/bams/
#$ -l h_rt=24:00:00,h_data=1G
#$ -N subBQSRs3
#$ -o /u/scratch/j/jarobins/irnp/reports
#$ -e /u/scratch/j/jarobins/irnp/reports
#$ -m abe
#$ -M jarobins

# Step 3: recalibrate BAM
# NOTE: Need to carefully manage disk space usage!!!

QSUB=/u/systems/UGE8.0.1vm/bin/lx-amd64/qsub

SCRIPTDIR=/u/project/mcdb/rwayne/jarobins/utils/scripts/bam_processing/07_BQSR

cd /u/scratch/j/jarobins/irnp/bams/ReadsFiltered

for i in {34..35}; do
	IN_FILE=$(ls ${i}*.bam)
	${QSUB} ${SCRIPTDIR}/run_BQSR_step3_recalibratebam_011417.sh ${IN_FILE}
	sleep 1h
done
