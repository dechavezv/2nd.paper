#! /bin/bash

#$ -wd /u/home/d/dechavez/project-rwayne/rails.project/gvcf
#$ -l h_rt=18:00:00,h_data=12G,highp,h_vmem=40G
#$ -N MAPgVCF
#$ -o /u/home/d/dechavez/project-rwayne/rails.project/log/gVCFmap.out
#$ -e /u/home/d/dechavez/project-rwayne/rails.project/log/gVCFmap.err
#$ -m abe
#$ -M dechavezv

export map=/u/home/d/dechavez/project-rwayne/rails.project/map/rails.map.txt
export Gvcf=/u/home/d/dechavez/project-rwayne/rails.project/gvcf
export Reference=/u/home/d/dechavez/project-rwayne/rails.project/reference.genomes/InaccesibleRail/InaccesibleRail.fa
temp=/u/scratch/d/dechavez/rails.project/temp
export GenW=/u/home/d/dechavez/project-rwayne/rails.project/GennomeWorkSpace

cd ${Gvcf}

source /u/local/Modules/default/init/modules.sh
module load java
source activate gatk-intel

/u/home/d/dechavez/project-rwayne/gatk-4.1.4.1/gatk --java-options "-Xmx8G" GenomicsDBImport \
	--genomicsdb-workspace-path ${GenW} \
	--sample-name-map ${map} \
	--tmp-dir=${temp} \
	-L NODE_10000_length_31171_cov_19.6787_ID_19999 \
	-reader-threads 6

#/u/home/d/dechavez/project-rwayne/gatk-4.1.4.1/gatk --java-options "-Xmx8G" GenomicsDBImport \
#	$(for file in *.g.vcf.gz; do echo "-V $file "; done) \
#	--genomicsdb-workspace-path ${GenW} \
#	--tmp-dir=${temp} \
#	-L NODE_10000_length_31171_cov_19.6787_ID_19999
#### -reader-threads 6

