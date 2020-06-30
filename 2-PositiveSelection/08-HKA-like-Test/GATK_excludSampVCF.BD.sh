#!/bin/bash

#$ -l highp,h_rt=27:00:00,h_data=7G,h_vmem=20G
#$ -N splitVCFsampleBD
#$ -cwd
#$ -m bea
#$ -o /u/scratch/d/dechavez/HKA/log/
#$ -e /u/scratch/d/dechavez/HKA/log/
#$ -M dechavezv 
## #$ -t 1-38:1

###### $(printf %02d $SGE_TASK_ID)
### highmem

#i=$(printf %02d $SGE_TASK_ID)
i=X

# then load your modules:
. /u/local/Modules/default/init/modules.sh
module load java
module load samtools
source activate gatk-intel
                                     
export Reference=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa
export vcf=/u/scratch/d/dechavez/HKA/BD

mkdir -p /u/scratch/d/dechavez/HKA/BD/temp

export temp=/u/scratch/d/dechavez/HKA/BD/temp


java -jar -Xmx7g -Djava.io.tmpdir=${temp} /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T SelectVariants \
-R ${Reference} \
-V ${vcf}/bsve_joint_chr${i}_TrimAlt_Annot_Mask_Filter.vcf.gz  \
-sn Sve313 \
-sn Sve315 \
-sn Sve338 \
-o ${vcf}/PrunedCapt_bsve_joint_chr${i}_TrimAlt_Annot_Mask_Filter.vcf.gz 

# Index the vcf

echo -e "\nIndexing VCF\n"

/u/home/d/dechavez/tabix-0.2.6/tabix -p vcf ${vcf}/PrunedCapt_bsve_joint_chr${i}_TrimAlt_Annot_Mask_Filter.vcf.gz

echo -e "\nFinish Indexing VCF\n"
