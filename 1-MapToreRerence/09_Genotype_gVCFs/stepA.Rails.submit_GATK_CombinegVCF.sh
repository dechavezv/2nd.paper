#! /bin/bash

#Note on GATK4 you cannot combine gvcf and GenotypeGVCFs at the same time. You have to do either GenomicsDBImport or CombineGVCFs.
#I cannot use GenomicsDBImport because Atlantisia reference has thousands of scaffolds and this tool create as many subfolders as number of scaffolds.
#That will be to may subfolders. Therefore I decide to use CombineGVCFs, which is the same but is more time and memmory consuming.
#Then I planed to used the combined gVCF as unput on the next step that is GenotypeGVCFs

#$ -wd /u/home/d/dechavez/project-rwayne/rails.project/gvcf
#$ -l highmem,h_rt=28:00:00,h_data=14G,highp,h_vmem=40G
#$ -N CombineGvcf
#$ -o /u/home/d/dechavez/project-rwayne/rails.project/log/CombineGvcf.out
#$ -e /u/home/d/dechavez/project-rwayne/rails.project/log/CombineGvcf.err
#$ -m abe
#$ -M dechavezv


export Gvcf=/u/home/d/dechavez/project-rwayne/rails.project/gvcf
export Reference=/u/home/d/dechavez/project-rwayne/rails.project/reference.genomes/InaccesibleRail/InaccesibleRail.fa
temp=/u/scratch/d/dechavez/rails.project/temp

cd ${Gvcf}

source /u/local/Modules/default/init/modules.sh
module load java
source activate gatk-intel

/u/home/d/dechavez/project-rwayne/gatk-4.1.4.1/gatk --java-options "-Xmx13G" \
CombineGVCFs \
-R ${Reference} \
$(for file in *.g.vcf.gz; do echo "-V $file "; done) \
-O ${Gvcf}/rails_cohort_GATK_HC_BPR.g.vcf.gz \
--tmp-dir=${temp}
