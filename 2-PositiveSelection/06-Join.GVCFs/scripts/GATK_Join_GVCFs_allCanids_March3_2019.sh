#!/bin/bash
#$ -l highp,h_rt=38:00:00,h_data=22G
#$ -pe shared 1
#$ -N JoinchrBBJ_SSJ
#$ -cwd
#$ -m bea
#$ -o /u/scratch/d/dechavez/GVCFs/ALLcanids_July2_2019/log/Joinchr_SSJ_BBJ.out
#$ -e /u/scratch/d/dechavez/GVCFs/ALLcanids_July2_2019/log/Joinchr_SSJ_BBJ.err
#$ -M dechavezv
## #$ -t 1-38:1
######
### highmem

# then load your modules:
. /u/local/Modules/default/init/modules.sh
 
module load java
module load samtools/0.1.19

export Reference=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa
export vcf=/u/scratch/d/dechavez/GVCFs/ALLcanids_July2_2019
export temp=/u/scratch/d/dechavez/GVCFs/ALLcanids_July2_2019
export output=/u/scratch/d/dechavez/GVCFs/ALLcanids_July2_2019/Output

cd ${vcf}

echo "#######"
echo "Joint_VCF_Files"
echo "########"

java -jar -Xmx15g -Djava.io.tmpdir=${temp} /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R ${Reference} \
-V African_chr$1.g.vcf.gz \
-V Andean_chr$1.g.vcf.gz \
-V Coyote_chr$1.g.vcf.gz \
-V Dhole_chr$1.g.vcf.gz \
-V Ethiopian_chr$1.g.vcf.gz \
-V GoldenW_chr$1.g.vcf.gz \
-V GrayF_chr$1.g.vcf.gz \
-V GrayW_chr$1.g.vcf.gz \
-V Jackal_chr$1.g.vcf.gz \
-V MW_chr$1.g.vcf.gz \
-V SSJ_chr$1.g.vcf.gz \
-V BBJ_chr$1.g.vcf.gz \
-V BD_chr$1.g.vcf.gz \
-o ${output}/July2nd_2019_chr$1_canidsNO_BD.vcf.gz \
-allSites \
--max_alternate_alleles 12

# Index the bam

echo -e "\nIndexing VCF\n"

/u/home/d/dechavez/tabix-0.2.6/tabix -p vcf \
${vcf}/July2nd_2019_chr$1_canidsNO_BD.vcf.gz

echo -e "\nFinish Indexing VCF\n"

#### -V bushDog_chr$1.g.vcf.gz \
