#!/bin/bash

#Use highmem te reserve a whole node

#$ -l highp,h_rt=22:00:00,h_data=5G
#$ -N FASTAQC_Atel
#$ -cwd
#$ -m bea
#$ -o /u/scratch/d/dechavez/QB3ateloc/log/FASTAQC.out
#$ -e /u/scratch/d/dechavez/QB3ateloc/log/FASTAQC.err
#$ -M dechavezv

# then load your modules:
. /u/local/Modules/default/init/modules.sh
module load java

export RAW_read=/u/scratch/d/dechavez/QB3ateloc
export FASTAQC=/u/home/d/dechavez/project-rwayne/FastQC

echo "########"
echo "Fasta_quality_check"
echo "#######"

FastaQC_fn () {
	echo "***** Beginning FastaqC of $1 *****"

 	${FASTAQC}/fastqc ${RAW_read}/${1}_R1_001.fastq.gz 
	${FASTAQC}/fastqc ${RAW_read}/${1}_R2_001.fastq.gz

        echo "***** $1 processing complete *****"
}

FastaQC_fn $1
