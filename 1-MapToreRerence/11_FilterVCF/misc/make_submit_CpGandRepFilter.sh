#! /bin/bash

#everything must be referred to by full path

mydir=/u/home/j/jarobins/project-rwayne

for f in fox{01..15}
do
	(
	echo "#! /bin/bash"
	echo "#$ -wd $mydir/fox/vcfs"
	echo "#$ -l h_rt=24:00:00,h_data=2G"
	echo "#$ -N ${f}_rmCpGandRep"
	echo "#$ -o $mydir/fox/vcfs/${f}_rmCpGandRep.out"
	echo "#$ -e $mydir/fox/vcfs/${f}_rmCpGandRep.err"
	echo "#$ -m abe"
	echo "#$ -M jarobins"
	echo "#$ -t 1-38:1"
	echo "cd $mydir/fox/vcfs"
	echo "$mydir/programs/htslib-1.3.1/tabix -h $mydir/fox/vcfs/unfiltered/${f}*.vcf.gz chr\$(printf "%02d" "\$SGE_TASK_ID") | "
	echo "$mydir/programs/bedtools2/bin/intersectBed -v -sorted -header -a stdin -b $mydir/beds/CpG_and_repeat_filter_cf31_fixed_sorted.bed | " 
	echo "$mydir/programs/htslib-1.3.1/bgzip > $mydir/fox/vcfs/${f}_UG_q20_emitall_chr\$(printf "%02d" "\$SGE_TASK_ID")_rmCpGandRepeats.vcf.gz" 
	) > "$mydir/scripts/filtervcf/submit_rmCpGandRep.sh"
	
	qsub $mydir/scripts/filtervcf/submit_rmCpGandRep.sh
done
