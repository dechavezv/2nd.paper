#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/
#$ -l h_rt=04:00:00,h_data=1G
#$ -N DPtot
#$ -o /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -e /u/home/j/jarobins/project-rwayne/fox/vcfs/reports
#$ -m abe
#$ -M jarobins

source /u/local/Modules/default/init/modules.sh
module load R

cd /u/home/j/jarobins/project-rwayne/fox/vcfs/joint_vcfs/trim_alternates/stats

cat ./*DP.table | grep -v -e [DPNA] | sort -n | uniq -c > DP_counts.txt

sed -r 's/^\s+//g' DP_counts.txt | Rscript -e 'dat<-read.table(file("stdin"), header=F, sep=" "); (which((cumsum(dat[,1])/sum(dat[,1]))>.99)[1])-2'
