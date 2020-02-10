#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/rails.project/VCF
#$ -l h_rt=18:00:00,h_data=21G,highp
#$ -N GTgVCF
#$ -o /u/home/d/dechavez/project-rwayne/rails.project/log/GTgVCF.out
#$ -e /u/home/d/dechavez/project-rwayne/rails.project/log/GTgVCF.err
#$ -m abe
#$ -M dechavezv

export Gvcf=/u/home/d/dechavez/project-rwayne/rails.project/gvcf
export VCF=/u/home/d/dechavez/project-rwayne/rails.project/VCF
export Reference=/u/home/d/dechavez/project-rwayne/rails.project/reference.genomes/InaccesibleRail/InaccesibleRail.fa
temp=/u/scratch/d/dechavez/rails.project/temp

cd ${Gvcf}

source /u/local/Modules/default/init/modules.sh
module load java
source activate gatk-intel

/u/home/d/dechavez/project-rwayne/gatk-4.1.4.1/gatk --java-options "-Xmx20G" \
GenotypeGVCFs \
-R ${Reference} \
-allSites \
-stand_call_conf 00.0 \
$(for file in *.g.vcf.gz; do echo "-V '${Gvcf}' "; done) \
--tmp-dir=${temp} \
-o ${VCF}/rails_joint_GATK_HC_BPR.vcf.gz 
