# The purpose of this pipe is to mege varaint callings from different spescies \
# into a single VCF file. This use useful to cinduct analysis that perform site evaluation among spescies.

1.As input you will need the g.vcf files generated on step 1 from all species.
  Here there are stored in data/g_VCF

2. To run the pipe just type the following:
	`qsub submit.gvcf.sh`

# this pipe is better than sed beacuse it doesnt iterate trough every line
# However the tool can be aplied to independet VCF files as well
# Provide a file with the sample(s) you want to change and named it header.txt
# Within header.txt only samples which need to be renamed can be listed as "old_name new_name\n" pairs separated by whitespaces, each on a separate line. If a sample name contains spaces, the spaces can be escaped using the backslash character, for example "Not\ a\ good\ sample\ name".
# Run the following command (this will only work if your files start with the name Canid, if not change Canid to whatever letters tour file start with):
# for file in Cani*; do (bcftools reheader -s header.txt $file > Reheader_$file && tabix -p vcf Reheader_$file);done
# Alternatively you can write the command in a bash script and named it Reheader_Canids_GVCFs.sh and called like this: qsub Reheader_Canids_GVCFs.sh 
# if you have only one VCF file run the same as before but withouth the for loop and index your vcf (indexing alredy included in the previous command)
# bcftools reheader -s header.txt <name_vcf> > Reheader_<name_vcf>
# tabix -p vcf Reheader_<name_vcf>
# for more information got to "https://samtools.github.io/bcftools/bcftools.html"


