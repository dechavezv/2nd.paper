Important:
To date March 20 2017, Samtools pipe seems to be the best one to extracted CDS sequences for downstrem analysis.


Before running the pipeline make sure of the following:
-Within the Genome folder verify that you have 'Ns' in the sequences, if not they were obtained with GATK alterantive reference, wich may not be recomendable for our Pipeline.
-Within the Genome folder verify that you DONT HAVE lower case letters, this are basese that were maskes by samtools for having to low or hihg Depth coverage values.
-If you find lowercase letters in your genomes, use the following command line to fixed them:
-python lowercase_to_N.py <infile.fasta> # the oupur will be called Masked_depth_<name_of_input>
-the tips of the tree must have the same name as the headers of the fasta files
-the foreground branch must be marker with $1
-make sure that the header of fasta files are seprate by '|' instead of '\t', if not use sed the following:
sed -e 's/\t/\|/g' your_file > output_file
-make sure that you dont have a database.fas file alredy in this directory, it you do deleated before running the pipeline 

Use the following order to run the Pipeline
1. From this directory run Prepare_to_PALM_SETUP_I_Part_PRANK.sh
2. Within Processing in each directory bash PAML_aling_PRANK.sh
Note: step 2 must be run in parallel; a loop will take forever 
3. From this directory run Create_codon_aminoacid_table.sh
4. Within Processing in each directory run Prepare_to_PALM_SETUP_II_Part_PRANK.sh
