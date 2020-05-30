#! /bin/bash
#$ -wd /u/flashscratch/j/jarobins/vcfs/DPstats
#$ -l h_rt=24:00:00,h_data=2G
#$ -N DPtot
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -m abe
#$ -M jarobins

source /u/local/Modules/default/init/modules.sh
module load R

cd /u/flashscratch/j/jarobins/vcfs/DPstats

OUTFILE=IRNP_44_joint_DPtot_autos_99percentile.txt

cat *_DPStatsTable.txt | cut -f1 | grep -v -e [DPNA] | sort -n | uniq -c | sed -r 's/^\s+//g' | \
Rscript -e 'dat<-read.table(file("stdin"), header=F, sep=" "); (which((cumsum(dat[,1])/sum(dat[,1]))>.99)[1])-2' > ${OUTFILE}
