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

SCRIPT=/u/project/mcdb/rwayne/jarobins/utils/scripts/bam_processing/07_BQSR/run_BQSR_step3_recalibratebam_012317.sh

IN_DIR=/u/scratch/j/jarobins/irnp/bams/BQSR/recal2
OUT_DIR=/u/scratch/j/jarobins/irnp/bams/BQSR/recal3

ROUND=3

cd ${IN_DIR}

for i in {29..35}; do
	IN_FILE=$(ls ${i}*.bam)
	${QSUB} -N BQSR_s3_r${ROUND} ${SCRIPT} ${IN_FILE} ${IN_DIR} ${OUT_DIR} ${ROUND}
	sleep 2h
done
