#!/bin/bash

#$ -l  highp,h_rt=10:00:00,h_data=1G
#$ -pe shared 1
#$ -N byChraligbamTofasta
#$ -cwd
#$ -m bea
#$ -o /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/01_fromBamTofasta/log/byChraligbamTofasta.out
#$ -e /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/01_fromBamTofasta/log/byChraligbamTofasta.err
#$ -M dechavezv

# then load your modules:
. /u/local/Modules/default/init/modules.sh
module load bcftools
module load samtools

#what chr?
i=$1

export BAM=/u/home/d/dechavez/project-rwayne/red.fox/vulp.SRR5328113.red.fox.chr$i.MarkDup_Filtered.bam
export REF=/u/home/d/dechavez/project-rwayne/canfam31/canfam31.fa
export Direc=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/01_fromBamTofasta
export data=/u/home/d/dechavez/project-rwayne/2nd.paper/data/Whole.genome.fasta.Jan.2020

## echo -e "\n Getting genome in FASTA format\n"

cd ${Direc}
mkdir Bychr

samtools mpileup -Q 20 -q 20 -u -v \
-f ${REF} ${BAM} | \
bcftools call -c | \
vcfutils.pl vcf2fq -d 3 -D $2 -Q 20 > ${BAM}.fq
/u/home/d/dechavez/seqtk/seqtk seq -aQ33 -q20 -n N ${BAM}.fq > Bychr/$3_chr$1.fa
cat Bychr/* > ${data}/$3.fa

sleep 5h

rm *.fq
rm -rf Bychr
