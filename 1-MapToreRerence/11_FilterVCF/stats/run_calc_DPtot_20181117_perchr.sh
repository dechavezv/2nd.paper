#! /bin/bash
#$ -wd /u/flashscratch/j/jarobins/vcfs/DPstats
#$ -l h_rt=24:00:00,h_data=2G
#$ -N DPtot
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -m abe
#$ -M jarobins
#$ -t 6-6:1

source /u/local/Modules/default/init/modules.sh
module load R

cd /u/flashscratch/j/jarobins/vcfs/DPstats

INFILE=IRNP_44_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot.vcf.gz_DPStatsTable.txt
OUTFILE=IRNP_44_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot.vcf.gz_DP_99percentile.txt

cut -f1 ${INFILE} | grep -v -e [DPNA] | sort -n | uniq -c | sed -r 's/^\s+//g' | \
Rscript -e 'dat<-read.table(file("stdin"), header=F, sep=" "); (which((cumsum(dat[,1])/sum(dat[,1]))>.99)[1])-2' > ${OUTFILE}
