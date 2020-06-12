#! /bin/bash

# Run this script to make and submit job array scripts for each individual.
# Here, the for-loop is over the chromosomes and the array is over the individuals.
# The script is generated and submitted, and then overwritten with each subsequent iteration of the for-loop.

# Runtimes vary according to chromosome length.

# I submitted chromosome separately, in three parts.
# Chromosomes 01-12 were submitted with a 40-hr requested runtime.
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
	echo "#$ -wd /u/scratch/d/dechavez/IndelReal"
	echo "#$ -l h_rt=30:00:00,h_data=22G,highp"
	echo "#$ -t 01-4:1"
	echo "#$ -N HC_MW_${i}"
	echo "#$ -o /u/scratch/d/dechavez/IndelReal/log/reports"
	echo "#$ -e /u/scratch/d/dechavez/IndelReal/log/reports"
	echo "#$ -m abe"
	echo "#$ -M dechavezv"
	echo
	echo "source /u/local/Modules/default/init/modules.sh"
	echo "module load java"
	echo
	echo "cd /u/scratch/d/dechavez/IndelReal"
	echo
	echo "export BAM=\$(ls bcbr\$(printf "%02d" "\$SGE_TASK_ID")_Aligned.MarkDup_Filtered.bam)"
	echo "export ID=\${BAM%_Aligned.MarkDup_Filtered.bam}"
	echo
	echo "java -jar -Xmx16g /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \\"
	echo "-T HaplotypeCaller \\"
	echo "-R /u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa \\"
	echo "-ERC BP_RESOLUTION \\"
	echo "-mbq 20 \\"
	echo "-out_mode EMIT_ALL_SITES \\"
	echo "-L chr${i} \\"
	echo "-I \${BAM} \\"
	echo "-o /u/scratch/d/dechavez/MW/GVCFs/\${ID}_chr${i}.g.vcf.gz"
	
	) > "run_GATK_HC_MW_chr13_22_highp.sh"

	qsub run_GATK_HC_MW_chr13_22_highp.sh

done
