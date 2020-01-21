#! /bin/bash
#$ -wd /u/scratch/j/jarobins/irnp/vcfs/joint
#$ -l h_rt=24:00:00,h_data=1G
#$ -N DPtot
#$ -o /u/scratch/j/jarobins/irnp/reports
#$ -e /u/scratch/j/jarobins/irnp/reports
#$ -m abe
#$ -M jarobins
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load R

cd /u/scratch/j/jarobins/irnp/vcfs/joint

cut -f1 IRNP_35_joint_chr$(printf %02d $SGE_TASK_ID).vcf.gz_StatsTable.txt | grep -v -e [DPNA] | sort -n | uniq -c | sed -r 's/^\s+//g' | \
Rscript -e 'dat<-read.table(file("stdin"), header=F, sep=" "); (which((cumsum(dat[,1])/sum(dat[,1]))>.99)[1])-2' > IRNP_35_joint_chr$(printf %02d $SGE_TASK_ID).vcf.gz_DP_99percentile.txt
