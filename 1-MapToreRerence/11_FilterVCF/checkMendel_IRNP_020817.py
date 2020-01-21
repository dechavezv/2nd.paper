# script to tally genotypes that do/do not follow proper Mendelian inheritance between parent and offspring

# Usage example: python checkMendel_IRNP_020817.py infile.vcf.gz 1

import sys
import gzip

# open input file (gzipped VCF file)
filename = sys.argv[1]
VCF = gzip.open(filename, 'r')

# set variables
if len(sys.argv)>2:
	chromo = sys.argv[2]
	if len(chromo)==1: chromo='0'+chromo
	chromo='chr'+chromo

passing=[0,0,0,0]
failing=[0,0,0,0]
missing=[0,0,0,0]

for line in VCF:
	if line.startswith('#'):continue
	line=line.split('\t')
	if line[6]!='PASS': continue
	parents=[line[14].split(':')[0],line[16].split(':')[0],line[16].split(':')[0],line[20].split(':')[0]]
	offspring=[line[17].split(':')[0],line[15].split(':')[0],line[21].split(':')[0],line[18].split(':')[0]]
	for i in range(0,len(parents)):
		if parents[i]=='./.' or offspring[i]=='./.': missing[i]+=1
		elif any(j in offspring[i].split('/') for j in parents[i].split('/')): passing[i]+=1
		else: failing[i]+=1

print('chromo\tCL062_CL075_pass\tCL067_CL065_pass\tCL067_CL175_pass\tCL152_CL141_pass\tCL062_CL075_fail\tCL067_CL065_fail\tCL067_CL175_fail\tCL152_CL141_fail\tCL062_CL075_miss\tCL067_CL065_miss\tCL067_CL175_miss\tCL152_CL141_miss\n')
print('%s\t%s\t%s\t%s\n' % (chromo,'\t'.join(map(str,passing)),'\t'.join(map(str,failing)),'\t'.join(map(str,missing))))

exit()
