#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/GVCF/
#$ -l highp,h_data=20G,h_rt=33:00:00,h_vmem=40G
#$ -t 01-38:1
#$ -N GTgVCF
#$ -o /u/home/d/dechavez/project-rwayne/GVCF/log/
#$ -e /u/home/d/dechavez/project-rwayne/GVCF/log/
#$ -m abe
#$ -M dechavezv

source /u/local/Modules/default/init/modules.sh
module load java

export Sps=/u/home/d/dechavez/project-rwayne/GVCF/Sps.txt

i=$(printf "%02d" "$SGE_TASK_ID")

java -jar -Xmx20g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \
-allSites \
-L chr${i} \
$(for line in $(cat $Sps); do echo "-V /u/home/d/dechavez/project-rwayne/GVCF/${line}_chr${i}.g.vcf.gz "; done) \
-o /u/home/d/dechavez/project-rwayne/SA.VCF/Combined/SA_chr${i}.vcf.gz
