#! /bin/bash

for i in {01..38} X; 

	do (
	echo "#! /bin/bash"
	echo "#$ -wd /u/scratch/j/jarobins/irnp/"
	echo "#$ -l h_rt=24:00:00,h_data=22G,arch=intel*"
	echo "#$ -t 1-9:1"
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
	echo "BAM=\$(ls \$(printf "%02d" "\$SGE_TASK_ID")*_Aligned_MarkDup_Filtered.bam_BQSR1_recal.bam_BQSR2_recal.bam_BQSR3_recal.bam)"
	echo "ID=\${BAM%_Aligned_MarkDup_Filtered.bam_BQSR1_recal.bam_BQSR2_recal.bam_BQSR3_recal.bam}"
	echo
	echo "java -jar -Xmx16g /u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar \\"
	echo "-T HaplotypeCaller \\"
	echo "-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \\"
	echo "-ERC BP_RESOLUTION \\"
	echo "-mbq 20 \\"
	echo "-out_mode EMIT_ALL_SITES \\"
	echo "-L chr${i} \\"
	echo "-I \${BAM} \\"
	echo "-o /u/scratch/j/jarobins/irnp/vcfs/\${ID}_chr${i}.g.vcf.gz"
	
	) > "run_step8_GATK_HC_IRNP_chr_all_121816.sh"

	qsub run_step8_GATK_HC_IRNP_chr_all_121816.sh

done

