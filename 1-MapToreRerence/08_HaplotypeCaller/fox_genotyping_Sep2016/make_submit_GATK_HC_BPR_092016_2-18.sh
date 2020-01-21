#! /bin/bash

# Do remaining chromosomes

for i in {02..18}; 

	do (
	echo "#! /bin/bash"
	echo "#$ -wd /u/home/j/jarobins/project-rwayne"
	echo "#$ -l h_rt=24:00:00,h_data=32G"
	echo "#$ -t 1-15:1"
	echo "#$ -N HC_fox${i}"
	echo "#$ -o /u/scratch/j/jarobins/HC_fox${i}.out"
	echo "#$ -e /u/scratch/j/jarobins/HC_fox${i}.err"
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
	echo "-stand_emit_conf 0 \\"
	echo "-stand_call_conf 0 \\"
	echo "-L chr${i} \\"
	echo "-I /u/scratch/j/jarobins/fox/bams/fox\$(printf "%02d" "\$SGE_TASK_ID")*recal.bam \\"
	echo "-o /u/scratch/j/jarobins/fox/vcfs/fox\$(printf "%02d" "\$SGE_TASK_ID")_GATK_HC_BPR_chr${i}.g.vcf.gz"
	
	) > "submit_GATK_HC_BPR_092016_2-18.sh"

	qsub submit_GATK_HC_BPR_092016_2-18.sh

done

