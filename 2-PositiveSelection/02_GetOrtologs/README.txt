## PIPILENE OF POSITIVE SELECTION
Author: Daniel Chavez, 2020 ©


PLEASE READ THIS IMPORTANT INFORMATION BEFORE RUNING THE PIPELINE.
1. Make suere that you have a genome in fasta format in the following path as this will be the input to extract ortologs:
	2nd.paper/data/Whole.genome.fasta.Jan.2020/<your_genome_in_fasta>

1. Change the absolute paths with your own. These are within all .sh scripts.

    #The paths can be easily identify as they are always at the head of the bash scripts and are followed by the word `export` .
    #Notice that everything before 2nd.paper/ has to be replace with your own path.
    #For instance, if you want to change the current directory in Prepare_to_PALM_SETUP_I_Part_PRANK.sh you have to change:
        #From \

        export Direc=u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/02_GetOrtologs

        #To \

	export Direc=<your.path>/2nd.paper/2-PositiveSelection/02_GetOrtologs
    Do grep 'export' *.sh to check if all pahts have been changed.

2. Specify the name of your spescies by typing the following 
   sed -i 's/red.fox.fa/<your_spescies_here>/g' submit_exon_Extraction.sh
   #Alternatevily provide a list of spescies names and put it in the sctip directory

3. Make sure to split your bed files in at least 7 diferent files (same size or # lines). This will allow to parallelize the job.
   #if you end up having less than 7 bed files. Type the following:
    sed -i 's/..7/..<the_number_of_your_files_here> scripts/submit_exon_Extraction.sh

#AFTER CHEKING ALL THE INFO ABOVE !!! Run the pipeline just by typing the following:

qsub scripts/submit_exon_Extraction.sh

#Here are some notes about the sctips

# Extract_Exons_3.sh takes two arguments a b; Extract_Exons_3.sh a b
# a=the number of Directory from the sevent in total. For instance, DirCanis_familiaris_1.bed will be: a=1
# b=The name of the genome. For instance, b=cat
