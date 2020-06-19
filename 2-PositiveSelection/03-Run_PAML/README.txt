## PIPILENE OF POSITIVE SELECTION
Author: Daniel Chavez, 2020 ©


PLEASE READ THIS IMPORTANT INFORMATION BEFORE RUNING THE PIPELINE.
1. Change the absolute paths with your own. These are within the following scripts:

	Create_codon_aminoacid_table.sh
	Create_Output.sh
	move_file.sh
	PAML_aling_PRANK.sh
	Prepare_to_PALM_SETUP_II_part.sh
	Prepare_to_PALM_SETUP_I_Part_PRANK.sh
	submit_PAML.sh

    #The paths can be easily identify as they are always at the head of the bash scripts and are followed by the word `export`.
    #Notice that everything before 2nd.paper/ has to be replace with your own path.
    #For instance, if you want to change the current directory in Prepare_to_PALM_SETUP_I_Part_PRANK.sh you have to change:
	#From \

	export Direc=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/03-Run_PAML
	
	#To \
	
	export Direc=<your.path>/2nd.paper/2-PositiveSelection/03-Run_PAML
    Do grep 'export' *.sh to check if all pahts have been changed.

2.  Add your genomes to the following path 2nd.paper/data/Genomes.canids.Jan.2020.Ortologs.fasta

3.  Change the files calles 'tree.txt' located in scripts with your own file. The tree must be in newick format. If your tree has branch lengths should look something like this:
    (Caur:0.001124214405,((Cfam:0.00145430755,Clupu:0.0003386485547);

    #If no branch lengths are in provide, your tree should then look like this:
    (Caur,((Cfam,Clupu);

4. Change the forward branch for wathever species you are testing as subject to positive selection. To do this run the following command.
   sed -i 's/Sven/<your_spescies_here>/g' scripts/Prepare_to_PALM_SETUP_II_part.sh  

5. Install Vespa. For more details about the program go here: http://www.mol-evol.org/VESPA
   #For hoffman users this is how you intal vespa:

   wget http://mol-evol.org/wp-content/uploads/2015/12/VESPA-1.0.tar.gz
   tar xvf VESPA-1.0.tar.gz
   cd VESPA-1.0
   export PERL5LIB=$HOME/VESPA-1.0:$PERL5LIB
   module load python
   pip install --user -U dendropy

   #To use it, for example:

   python $HOME/VESPA-1.0 vespa.py help translate

   #Notice that the tree following lines have alredy been included in our bash scipts. But here it is in case you need to change PERL Library version or want to run things interactively  by yourself

   . /u/local/Modules/default/init/modules.sh
   module load python/2.7.3
   export PERL5LIB=$HOME/VESPA-1.0:$PERL5LIB	
   
6. Some important NOTEs about the input data:
	-To date January 2020 Samtools is the best option to obatain fasta sequences; see step 2-GetOrtologs for further details.
	-Verify that you genomes have 'Ns' in the sequences, if not they were obtained with GATK alterantive reference or bedtools. Nt having N's overestimate squences quality.
	-Verify that you genomes DONT HAVE lower case letters. They need to be masked; use the following command line to replace lowecase by N's:
	 python scripts/lowercase_to_N.py <your_genome_here> # the ouput will be called Masked_depth_<name_of_input>
	-the tips of the file tree.txt must mach the names of your species in your genomes.
	-make sure that you dont have a database.fas file alredy in this directory, it you do deleated before running the pipeline as it may cause problems 
	-Verify that you have a config file on tree/modelAnull/Omega1 and tree/modelA/Omega1
#AFTER CHEKING ALL THE INFO ABOVE !!! Run the pipeline just by typing the following:

qsub scripts/submit_PAML.sh

#GOOD LUCK :-)

