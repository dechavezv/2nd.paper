#! /bin/bash

# Run this script to make and submit job array scripts for each individual.
# Here, the for-loop is over the chromosomes and the array is over the individuals.
# The script is generated and submitted, and then overwritten with each subsequent iteration of the for-loop.

# Runtimes vary according to chromosome length.

# I submitted chromosome 1 separately, in two parts.
# Chromosomes 13-22 were submitted with a 30-hr requested runtime.
# Chromosomes 23-38 were submitted with a 24-hr requested runtime in the 24-hr queue (not highp).

# Runtime is about twice as long if non-intel chips are used!
# Our group has only intel chips so I don't specify the architecture,
# but when I submit to the 24-hr queue I add arch=intel* to the -l line of the script header.

# Sometimes, for whatever reason, jobs would go slowly and run out of time and I just resubmitted
# those failed ones individually as needed.

# I'm not totally sure about the wisdom of using the --dontUseSoftClippedBases option, 
# but I know I used it last time, so I kept it here for consistency with the previous fox study.

for i in {13..22}; 

	do (
	echo "#! /bin/bash"
	echo "#$ -wd /u/scratch/j/jarobins/irnp/"
	echo "#$ -l h_rt=30:00:00,h_data=22G,highp"
	echo "#$ -t 10-19:1"
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
	
	) > "run_step8_GATK_HC_IRNP_chr13-22_highp.sh"

	qsub run_step8_GATK_HC_IRNP_chr13-22_highp.sh

done

