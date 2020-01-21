#! /bin/bash

for i in {39..43}; 

	do (
	echo "#! /bin/bash"
	echo "#$ -wd /u/scratch2/j/jarobins/irnp/"
	echo "#$ -l h_rt=24:00:00,h_data=22G,arch=intel*"
	echo "#$ -t 1-38:1"
	echo "#$ -N HC_IRNP_${i}"
	echo "#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp"
	echo "#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp"
	echo "#$ -m abe"
	echo "#$ -M jarobins"
	echo
	echo "source /u/local/Modules/default/init/modules.sh"
	echo "module load java"
	echo
	echo "cd /u/scratch2/j/jarobins/irnp/"
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
	echo "-o /u/scratch2/j/jarobins/irnp/gvcfs/\${ID}_chr\$(printf %02d \$SGE_TASK_ID).g.vcf.gz"
	
	) > "run_GATK_HC_IRNP_chr_autosomes_050917.sh"

	qsub run_GATK_HC_IRNP_chr_autosomes_050917.sh

done

for i in {39..43}; 

	do (
	echo "#! /bin/bash"
	echo "#$ -wd /u/scratch2/j/jarobins/irnp/"
	echo "#$ -l h_rt=24:00:00,h_data=22G,arch=intel*"
	echo "#$ -N HC_IRNP_${i}_X"
	echo "#$ -o /u/home/j/jarobins/project-rwayne/reports/irnp"
	echo "#$ -e /u/home/j/jarobins/project-rwayne/reports/irnp"
	echo "#$ -m abe"
	echo "#$ -M jarobins"
	echo
	echo "source /u/local/Modules/default/init/modules.sh"
	echo "module load java"
	echo
	echo "cd /u/scratch2/j/jarobins/irnp/"
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
	echo "-L chrX \\"
	echo "-I \${BAM} \\"
	echo "-o /u/scratch2/j/jarobins/irnp/gvcfs/\${ID}_chrX.g.vcf.gz"
	
	) > "run_GATK_HC_IRNP_chr_X_050917.sh"

	qsub run_GATK_HC_IRNP_chr_X_050917.sh

done
