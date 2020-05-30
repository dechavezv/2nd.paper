#! /bin/bash
#$ -wd /u/scratch/d/dechavez/rails.project/VCF
#$ -l highp,h_vmem=64G,h_rt=24:00:00,h_data=20G
#$ -N trim_annot
#$ -o /u/scratch/d/dechavez/rails.project/VCF/log/
#$ -e /u/scratch/d/dechavez/rails.project/VCF/log/
#$ -m abe
#$ -M dechavezv

#highmem,highp

source /u/local/Modules/default/init/modules.sh
module load java

GATK=/u/local/apps/gatk/3.7/GenomeAnalysisTK.jar
REFERENCE=/u/home/d/dechavez/project-rwayne/rails.project/reference.genomes/InaccesibleRail/chr_and_superScafolds/InaccesibleRail.chr.fa

cd /u/scratch/d/dechavez/rails.project/VCF

java -jar -Xmx6g ${GATK} \
-T SelectVariants \
-R ${REFERENCE} \
-trimAlternates \
-L PseudoChr_W \
-V LS_joint_chrW.vcf.gz \
-o LS_joint_chrW_TrimAlt.vcf.gz

java -jar -Xmx20g ${GATK} \
-T VariantAnnotator \
-R ${REFERENCE} \
-G StandardAnnotation \
-A VariantType \
-A AlleleBalance \
-L PseudoChr_W \
-V LS_joint_chrW_TrimAlt.vcf.gz \
-o LS_joint_chrW_TrimAlt_Annot.vcf.gz 
