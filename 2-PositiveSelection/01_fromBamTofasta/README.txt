## PIPILENE OF POSITIVE SELECTION
Author: Daniel Chavez, 2020 ©


PLEASE READ THIS IMPORTANT INFORMATION BEFORE RUNING THE PIPELINE.
1. Change the absolute paths with your own. These are within all .sh scripts.

    #The paths can be easily identify as they are always at the head of the bash scripts and are followed by the word `export` .
    #Notice that everything before 2nd.paper/ has to be replace with your own path.
    #For instance, if you want to change the current directory within from_AlignedBam_To_Fasta.sh, you have to change:
        #From \

        export Direc=u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/02_GetOrtologs

        #To \

	export Direc=<your.path>/2nd.paper/2-PositiveSelection/02_GetOrtologs
    Do grep 'export' *.sh to check if all pahts have been changed.

2. Indicate your input by changing the following with your won Bam file
export BAM=2nd_call_cat_samt_ug_hc_BBJ_raw.vcf.table.bam_${i}.bam

#From \

        export BAM=2nd_call_cat_samt_ug_hc_BBJ_raw.vcf.table.bam

        #To \
	
	export BAM=<name_of_your_file>

3. Specify the name of your spescies by typing the following 
   sed -i 's/red.fox/<your_spescies_here>/g' submit_fromAlignedBamToFasta.sh

4. Specify the 95th percentile of coverage yping the following
   sed -i 's/(depth_95th\=)\d+/\1<your_percentile>/g' submit_fromAlignedBamToFasta.sh

#AFTER CHEKING ALL THE INFO ABOVE !!! Run the pipeline just by typing the following:

qsub scripts/submit_fromAlignedBamToFasta.sh

