#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/MW/VCF/Stats
#$ -l h_rt=24:00:00,h_data=3G,h_vmem=10G
#$ -N meanDP
#$ -o /u/home/d/dechavez/project-rwayne/MW/VCF/Stats/log/DPmean/
#$ -e /u/home/d/dechavez/project-rwayne/MW/VCF/Stats/log/DPmean/
#$ -m abe
#$ -M dechavezv
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load R

cd /u/home/d/dechavez/project-rwayne/MW/VCF/Stats

export INFILE=bcbr_joint_chr$(printf %02d $SGE_TASK_ID).vcf.gz_DP.table
export OUTFILE=bcbr_joint_chr$(printf %02d $SGE_TASK_ID)_TrimAlt_Annot.vcf.gz_DP_mean.txt
export SpsList=Cbr.sp.txt

#this script will calcualte the meand from a multipleIndiv. VCF file \
#IMORTANT: names from sp.list must match header of depth.table. For instance, \
#`Cb17082018` in sp.list and `Cb17082018.DP` in header of depth.table.

for line in $(cat ${SpsList}); do \
(echo $line && cat ${INFILE} | \
grep -v 'NA' | \
Rscript -e 'dat<-as.data.frame(read.table(file("stdin"), header=T, sep="")); newdat <-subset(dat,select='$line'.DP); mean(newdat$'$line'.DP)');done > ${OUTFILE}

#After this script is complete, cd to the ouput directory and run \
#the following line that will give you the mean DP of all chr:

#for line in $(cat Cbr.sp.txt); do grep -A1 $line .gz_DP_mean.txt | grep '\[' | perl -pe 's/.*(\s+\d+\.\d+)/\1/g' | awk '{ sum += $1; n++ } END { if (n > 0) print sum / n; }';done
