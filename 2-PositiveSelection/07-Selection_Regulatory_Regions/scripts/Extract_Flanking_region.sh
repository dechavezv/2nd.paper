#!/bin/bash
#Use highmem te reserve a whole node

#$ -l highp,h_rt=5:00:00,h_data=1G
#$ -pe shared 1
#$ -N Flanking
#$ -cwd
#$ -m bea
#$ -o /u/home/d/dechavez/project-rwayne/Fastaq_CompleteGenomes_d4_D95th_phred33_masked/log/Flanking.out
#$ -e /u/home/d/dechavez/project-rwayne/Fastaq_CompleteGenomes_d4_D95th_phred33_masked/log/Flanking.err
#$ -M dechavezv

export mask=/u/home/d/dechavez/project-rwayne/scripts/Python
export tree=/u/home/d/dechavez/project-rwayne/Tree_Files/2nd.chapter/OK.Tree.d4_Q20_some25kb.NJ.2019.txt
export Genomes=/u/home/d/dechavez/project-rwayne/Fastaq_CompleteGenomes_d4_D95th_phred33_masked/Genomes
export prank=/u/home/d/dechavez/project-rwayne/PAML/Old

# load your modules:
. /u/local/Modules/default/init/modules.sh
module load python
module load bedtools


flank () {
	echo "************************ Author: Daniel Chavez, 2019 © ****************"
	echo "************************ Beginning extraction of $1 gene ****************"
	
	cd ${Genomes}	
	
	echo "************************ Getting flanking regions from Genomes ****************"
	for file in *.fasta; do (d=$(printf $file | perl -pe 's/_samtools_d4_d95th_phred33.fasta//'g) && \
	bedtools getfasta -fi $file -bed ../${1}/${1}.bed -fo ../${1}/${1}_${d}.fa);done

	cd ../${1}

	echo "************************ Editting header of $1.fa ****************"
	for file in *.fa; do (d=$(printf $file | perl -pe 's/'${1}'_//;s/.fa//g') && \
	perl -pe 's/>.*\n/>'${d}'\n/g' $file > Edited_$file && rm $file && mv Edited_$file $file);done
	
	rm *SRR29714*;rm *Kenyan*
	
	cat *.fa > Canids_${1}.fa
	
	perl -pe 's/SSJ/Cadus/;s/BBJ/Cmeso/;s/BD/Sven/;s/GoldenW/Caur/;s/Dog/Cfam/;s/GrayW/Clupu/;s/Coyote/Clat/;s/Jackal/Clupa/;s/Ethiopian/Csime/;s/Dhole/Calp/;s/African/Lpic/;s/MW/Cbrac/;s/Andean/Lcul/;s/GrayF/Ucin/g' Canids_${1}.fa > Edited_Canids_${1}.fa; rm Canids_${1}.fa; mv Edited_Canids_${1}.fa Canids_${1}.fa 
	python ${mask}/lowercase_to_N.py Canids_${1}.fa 

	echo "************************ Aligning $1 with prank ****************"
	${prank}/prank -d=Masked_depth_Canids_$1.fa -o=prank_Masked_depth_Canids_$1.fa -t=${tree} -F -once

	echo "************************ Remove intermedia files ****************"
 	rm Masked_*; rm Canids_*

	echo "************************ $1 gene processing complete  ****************"
}

flank $1 # privide name of the gene. For instance, `flank PRRX1`
