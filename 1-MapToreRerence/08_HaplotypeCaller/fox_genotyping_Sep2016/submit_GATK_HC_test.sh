#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne
#$ -l h_rt=24:00:00,h_data=32G,exclusive
#$ -N HCtest1
#$ -o /u/scratch/j/jarobins/HCtest1.out
#$ -e /u/scratch/j/jarobins/HCtest1.err
#$ -m abe
#$ -M jarobins
source /u/local/Modules/default/init/modules.sh
module load java

cd /u/scratch/j/jarobins

declare -A arr
arr[chr01]=122678785; arr[chr02]=85426708; arr[chr03]=91889043; arr[chr04]=88276631; arr[chr05]=88915250; arr[chr06]=77573801; arr[chr07]=80974532; arr[chr08]=74330416; arr[chr09]=61074082; arr[chr10]=69331447; arr[chr11]=74389097; arr[chr12]=72498081; arr[chr13]=63241923; arr[chr14]=60966679; arr[chr15]=64190966; arr[chr16]=59632846; arr[chr17]=64289059; arr[chr18]=55844845; arr[chr19]=53741614; arr[chr20]=58134056; arr[chr21]=50858623; arr[chr22]=61439934; arr[chr23]=52294480; arr[chr24]=47698779; arr[chr25]=51628933; arr[chr26]=38964690; arr[chr27]=45876710; arr[chr28]=41182112; arr[chr29]=41845238; arr[chr30]=40214260; arr[chr31]=39895921; arr[chr32]=38810281; arr[chr33]=31377067; arr[chr34]=42124431; arr[chr35]=26524999; arr[chr36]=30810995; arr[chr37]=30902991; arr[chr38]=23914537; arr[chrX]=123869142; arr[chrMT]=16727

java -jar /u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.6-0-g89b7209/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \
-ERC BP_RESOLUTION \
-mbq 20 \
-out_mode EMIT_ALL_SITES \
--dontUseSoftClippedBases \
-stand_emit_conf 0 \
-stand_call_conf 0 \
-L chr38:101-12000101 \
-I /u/scratch/j/jarobins/fox/bams/fox04_JARW003_bwaM_sortRG_picrmdup_merged_realign_readsfiltered.bam_BQSR1_recal.bam_BQSR2_recal.bam_BQSR3_recal.bam \
-o /u/scratch/j/jarobins/fox/vcfs/fox04_GATK_HC_BPR_chr38_test.g.vcf


