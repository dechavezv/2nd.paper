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

export scaf=/u/home/d/dechavez/project-rwayne/rails.project/bams/filtered.bam.files/subset.scafolds.Atlantisia.test.txt

for line in $(cat ${scaf}); 

	do (
	i=$(printf ${line} | perl -pe 's/.*_ID_(\d+)/\1/g')
	echo "#! /bin/bash"
	echo "#$ -wd /u/home/d/dechavez/project-rwayne/rails.project/gvcf"
	echo "#$ -l h_rt=42:00:00,h_data=22G,highp"
	echo "#$ -N HC_RAIL_${i}"
	echo "#$ -o /u/home/d/dechavez/project-rwayne/rails.project/gvcf/log/reports_${i}.out"
	echo "#$ -e /u/home/d/dechavez/project-rwayne/rails.project/gvcf/log/reports_${i}.err"
	echo "#$ -m abe"
	echo "#$ -M dechavezv"
	echo
	echo "source /u/local/Modules/default/init/modules.sh"
	echo "module load java"
	echo
	echo "export Reference=/u/home/d/dechavez/project-rwayne/rails.project/reference.genomes/InaccesibleRail/InaccesibleRail.fa"
	echo "export DIREC=/u/home/d/dechavez/project-rwayne/rails.project/bams/filtered.bam.files/splitBams"
	echo "export vcf=/u/home/d/dechavez/project-rwayne/rails.project/gvcf"
	echo "export BAM=GR2_S8_HWKG5BBXX_Aligned_MarkDup_Filtered.Atlantisia_${i}.bam"
	echo "export temp=/u/scratch/d/dechavez/rails.project/temp"
	echo
	echo "cd ${DIREC}"
	echo
	echo "java -jar -Xmx16g -Djava.io.tmpdir=${temp} /u/local/apps/gatk/3.7/GenomeAnalysisTK.jar \\"
	echo "-T HaplotypeCaller \\"
	echo "-R \${Reference} \\"
	echo "-I \${BAM} \\"
	echo "-L ${line} \\"
	echo "-o \${vcf}/\${BAM%.bam}.g.vcf.gz"
	echo "-ERC BP_RESOLUTION \\"
	echo "-mbq 10 \\"
	echo "-out_mode EMIT_ALL_SITES \\"
	echo "--dontUseSoftClippedBases"
	
	) > "run_GATK_HC_rails_Scafold_highp.sh"

	qsub run_GATK_HC_rails_Scafold_highp.sh

done

