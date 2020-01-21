# script to tally genotypes that do/do not follow proper Mendelian inheritance between parent and offspring

# Usage example: python checkMendel_IRNP_020817.py infile.vcf.gz 1

import sys
import gzip
import numpy

# open input file (gzipped VCF file)
filename = sys.argv[1]
VCF = gzip.open(filename, 'r')

# set variables
if len(sys.argv)>2:
	chromo = sys.argv[2]
	if len(chromo)==1: chromo='0'+chromo
	chromo='chr'+chromo

samples=[]
for line in VCF:
	if line.startswith('##'):
		pass
	else:
		for i in line.split()[9:]: samples.append(i)
		break

comps=numpy.zeros((3*len(samples), 3*len(samples)))

for line in VCF:
	if line.startswith('#'):continue
	line=line.split('\t')
	if line[6]!='PASS': continue
	GTs=line[9:]
	GTs=[i.split(':')[0] for i in GTs]
	for i in range(0,len(GTs)):
		for j in range(0,len(GTs)):
			if './.' in (GTs[i], GTs[j]): comps[i,j]+=1
			elif any(a in GTs[j] for a in GTs[i]): comps[i+len(samples),j+len(samples)]+=1
			else: comps[i+2*len(samples),j+2*len(samples)]+=1

outfile=open("IRNP_checkMendel_"+chromo+"_021017.txt", 'w')
outfile.write('_miss\t'.join(samples)+'_miss\t'+'_pass\t'.join(samples)+'_pass\t'+'_fail\t'.join(samples)+'_fail\n')
numpy.savetxt(outfile, X=comps, fmt='%i', delimiter="\t")
outfile.close()

exit()
