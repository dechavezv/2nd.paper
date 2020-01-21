#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/irnp/suspiciousregions
#$ -l h_rt=24:00:00,h_data=12G
#$ -N suspicious
#$ -o /u/home/j/jarobins/project-rwayne/reports
#$ -e /u/home/j/jarobins/project-rwayne/reports
#$ -m abe
#$ -M jarobins

source /u/local/Modules/default/init/modules.sh
module load java

cd /u/home/j/jarobins/project-rwayne/irnp/suspiciousregions

java -jar -Xmx8g /u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar \
-T VariantsToTable \
-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \
--allowMissingData \
--splitMultiAllelic \
-F ABHet -F AC -F AF -F AN -F DP -F NCALLED -F HET -F ExcessHet -F QUAL \
-F FS -F SOR -F BaseCounts -F BaseQRankSum -F ClippingRankSum -F DS \
-F HaplotypeScore -F InbreedingCoeff -F MQ -F MQRankSum -F QD -F ReadPosRankSum \
-V suspiciousregions.vcf.gz \
-o suspiciousregions.vcf.gz_StatsTable.txt

java -jar -Xmx8g /u/home/j/jarobins/project-rwayne/utils/programs/GenomeAnalysisTK-3.7-0-gcfedb67/GenomeAnalysisTK.jar \
-T VariantsToTable \
-R /u/home/j/jarobins/project-rwayne/utils/canfam31/canfam31.fa \
--allowMissingData \
--splitMultiAllelic \
-F ABHet -F AC -F AF -F AN -F DP -F NCALLED -F HET -F ExcessHet -F QUAL \
-F FS -F SOR -F BaseCounts -F BaseQRankSum -F ClippingRankSum -F DS \
-F HaplotypeScore -F InbreedingCoeff -F MQ -F MQRankSum -F QD -F ReadPosRankSum \
-V suspiciousregions_shuffle.vcf.gz \
-o suspiciousregions_shuffle.vcf.gz_StatsTable.txt
