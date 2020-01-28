PLEASE READ THIS IMPORTANT INFORMATION BEFORE RUNING THE PIPELINE.
1. This pipeline works with sequences that were alredy anayzed in step 03-Run_PAML, so \
   make suere that you have sequences in philip format in the following path as this will be the input to run SWAMP:
        2nd.paper/data/PAML/sequences_before_SWAMP/
	Sequences must be in phylip format like this:
	
	13 1245
	African	 ATTTTTTTTTTT
	Coyote  ATTTTTTTT
	.....

1. Change the absolute paths with your own. These are within all .sh scripts.

    #The paths can be easily identify as they are always at the head of the bash scripts and are followed by the word `export` .
    #Notice that everything before 2nd.paper/ has to be replace with your own path.
    #For instance, if you want to change the current directory in Prepare_to_PALM_SETUP_I_Part_PRANK.sh you have to change:
        #From \

        export Direc=u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/04-Run_SWAMP

        #To \

 	export Direc=<your.path>/2nd.paper/2-PositiveSel04-Run_SWAMP
 	Do grep 'export' *.sh to check if all pahts have been changed.

3. Provide your on newick tree file on the directory scripts/tree.
   IMPORTANT: Make sure your foward branch has beem label (e.g Sven#1)


#AFTER CHEKING ALL THE INFO ABOVE !!! Run the pipeline just by typing the following:

# run first part
qsub submit_SWMP.partI.sh 

# get branch lengths
# Read GetBranchLenghts.txt to know how to do this!!

# Once you have created your file with branch lengths, then run the second part of pipe
qsub submit_SWMP.partII.sh 
