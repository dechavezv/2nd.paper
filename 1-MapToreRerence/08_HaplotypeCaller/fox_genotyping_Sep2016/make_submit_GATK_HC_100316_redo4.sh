#! /bin/bash

for f in 14_12 15_06 15_10; 

	do (
	echo "#! /bin/bash"
	echo "#$ -wd /u/scratch/j/jarobins/fox"
	echo "#$ -l h_rt=24:00:00,h_data=21G,arch=intel-E5-2670"
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
	
	) > "submit_GATK_HC_100316_redo4.sh"

	qsub submit_GATK_HC_100316_redo4.sh

done