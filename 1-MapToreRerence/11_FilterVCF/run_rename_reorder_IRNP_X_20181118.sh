#! /bin/bash
#$ -wd /u/flashscratch/j/jarobins/vcfs
#$ -l h_rt=24:00:00,h_data=16G,arch=intel*
#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp
#$ -m abe
#$ -M jarobins
#$ -N rename

BGZIP=/u/home/j/jarobins/project-rwayne/utils/programs/htslib-1.3.1/bgzip
TABIX=/u/home/j/jarobins/project-rwayne/utils/programs/htslib-1.3.1/tabix

cd /u/flashscratch/j/jarobins/vcfs

VCF=${1}

# Rename

zcat ${VCF} | head -500 | grep "^#" | \
sed 's/UCI_GFO41F/GFO1/g' | \
sed 's/RKW7619/ARC1/g' | \
sed 's/RKW7639/ARC2/g' | \
sed 's/RKW7640/ARC3/g' | \
sed 's/RKW7649/ARC4/g' > head_${VCF}.txt

zcat ${VCF} | grep -v "^#" | \
cat head_${VCF}.txt - | \
${BGZIP} > ${VCF%.vcf.gz}_rename.vcf.gz

${TABIX} -p vcf ${VCF%.vcf.gz}_rename.vcf.gz


# Reorder

##### ERROR: The following failed

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar
REFERENCE=/u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa

java -jar -Xmx8g ${GATK} \
-T SelectVariants \
-R {REFERENCE} \
-L chrX \
-V ${VCF%.vcf.gz}_rename.vcf.gz \
-o ${VCF%.vcf.gz}_rename_reorder.vcf.gz 
