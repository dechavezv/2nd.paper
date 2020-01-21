#! /bin/bash

for f in 23_15 24_09 25_09 25_10 25_12 25_13 25_15 28_01 28_02 28_03 28_04 28_06 28_15 29_01 29_06 29_07 29_08 29_09 29_10 29_11 29_12 29_13 29_14 29_15 30_04 30_05 30_06 30_07 30_09 30_11 30_12 30_13 30_14 31_01 31_02 31_03 31_04 32_09 32_10 32_11 32_12 32_13 32_15 33_01 33_03 33_04 33_05 33_07 33_08 33_09 33_10 33_11 33_12; 

	do (
	echo "#! /bin/bash"
	echo "#$ -wd /u/scratch/j/jarobins/fox"
	echo "#$ -l h_rt=24:00:00,h_data=22G,arch=intel*"
	echo "#$ -N HC_re${f}"
	echo "#$ -o /u/scratch/j/jarobins/fox"
	echo "#$ -e /u/scratch/j/jarobins/fox"
	echo "#$ -m abe"
	echo "#$ -M jarobins"

	echo "source /u/local/Modules/default/init/modules.sh"
	echo "module load java"

	echo "cd /u/scratch/j/jarobins"

	echo "java -jar /u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.6-0-g89b7209/GenomeAnalysisTK.jar \\"
	echo "-T HaplotypeCaller \\"
	echo "-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \\"
	echo "-ERC BP_RESOLUTION \\"
	echo "-mbq 20 \\"
	echo "-out_mode EMIT_ALL_SITES \\"
	echo "--dontUseSoftClippedBases \\"
	echo "-L chr${f%_*} \\"
	echo "-I /u/scratch/j/jarobins/fox/bams/fox${f#*_}*recal.bam \\"
	echo "-o /u/scratch/j/jarobins/fox/vcfs/fox${f#*_}_GATK_HC_BPR_chr${f%_*}.g.vcf.gz"
	
	) > "submit_GATK_HC_092916_redo.sh"

	qsub submit_GATK_HC_092916_redo.sh

done