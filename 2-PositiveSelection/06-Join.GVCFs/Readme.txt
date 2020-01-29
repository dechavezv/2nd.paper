# The purpose of this pipe is to mege varaint callings from different spescies \
# into a single VCF file. This use useful to cinduct analysis that perform site evaluation among spescies.

1.As input you will need the g.vcf files for all spescies/individuals generated in step 1-MapToreRerence/09_Genotype_gVCFs.
  There were stored in data/g_VCF

2. change the header.txt with your won names
	# Within header.txt only samples which need to be renamed can be listed as "old_name new_name\n" pairs separated \
	by whitespaces, each on a separate line. If a sample name contains spaces, the spaces can be escaped using \
	the backslash character, for example "Not\ a\ good\ sample\ name".


2. To run the pipe just type the following:
	`qsub submit.gvcf.sh`



