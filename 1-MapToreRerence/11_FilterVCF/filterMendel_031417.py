# Script to mark sites with genotypes that do not follow proper Mendelian inheritance 
# between parent and offspring with "WARN_Mendel" in the filter field.

# Usage example: python checkMendel_IRNP_031417.py infile.vcf.gz

import sys
import gzip

# open input file (gzipped VCF file)
filename = sys.argv[1]
VCF = gzip.open(filename, 'r')

for line0 in VCF:
	if line0.startswith('#'):
		if line0.startswith('##FORMAT'):
			sys.stdout.write('##FILTER=<ID=WARN_Mendel,Description="Low quality">\n') 
			sys.stdout.write(line0)
			break
		else: sys.stdout.write(line0)
	
for line0 in VCF:
	if line0.startswith('#'): 
		sys.stdout.write(line0); continue
	line=line0.strip().split('\t')
	filter=[]
	if line[6]!='PASS': filter.append(line[6])
	fails=0
	parents=[line[14][:3],line[16][:3],line[16][:3],line[20][:3]]
	offspring=[line[17][:3],line[15][:3],line[21][:3],line[18][:3]]
	for i in range(0,len(parents)):
		if parents[i]=='./.' or offspring[i]=='./.': continue
		elif any(j in offspring[i].split('/') for j in parents[i].split('/')): continue
		else: fails+=1
	if fails>0: 
		filter.append('WARN_Mendel')
		sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), ';'.join(filter), '\t'.join(line[7:])) ); continue
	else:
		if filter==[]: filter.append('PASS')
		sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), ';'.join(filter), '\t'.join(line[7:])) ); continue

exit()
