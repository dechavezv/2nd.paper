#! /bin/bash

for i in 35; 

	do (
	echo "#! /bin/bash"
	echo "#$ -wd /u/scratch/j/jarobins/irnp/"
	echo "#$ -l h_rt=24:00:00,h_data=22G,arch=intel*"
	echo "#$ -t 1-38:1"
	echo "#$ -N HC_IRNP_${i}"
	echo "#$ -o /u/scratch/j/jarobins/irnp/reports"
	echo "#$ -e /u/scratch/j/jarobins/irnp/reports"
	echo "#$ -m abe"
	echo "#$ -M jarobins"
	echo
	echo "source /u/local/Modules/default/init/modules.sh"
	echo "module load java"
	echo
	echo "cd /u/scratch/j/jarobins/irnp/bams/BQSR/recal3/"
	echo "BAM=\$(ls ${i}*_BQSR3_recal.bam)"
	echo "ID=\${BAM%_Aligned*}"
	echo
	echo "java -jar -Xmx16g /u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar \\"
	echo "-T HaplotypeCaller \\"
	echo "-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \\"
	echo "-ERC BP_RESOLUTION \\"
	echo "-mbq 20 \\"
	echo "-out_mode EMIT_ALL_SITES \\"
	echo "--dontUseSoftClippedBases \\"
	echo "-L chr\$(printf %02d \$SGE_TASK_ID) \\"
	echo "-I \${BAM} \\"
	echo "-o /u/scratch/j/jarobins/irnp/vcfs/\${ID}_chr\$(printf %02d \$SGE_TASK_ID).g.vcf.gz"
	
	) > "run_GATK_HC_IRNP_chr_autosomes_012617.sh"

	qsub run_GATK_HC_IRNP_chr_autosomes_012617.sh

done
