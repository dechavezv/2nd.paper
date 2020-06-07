# script to tally genotype counts and number of genotypes called/not called

# Usage example 1: python HetPerInd_011017.py infile_chr01_filtered.vcf.gz
# Usage example 2: python HetPerInd_011017.py infile_chr01_filtered.vcf.gz 1

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

# get list of samples
samples=[]
for line in VCF:
	if line.startswith('##'):
		pass
	else:
		for i in line.split()[9:]: samples.append(i)
		break

nocalls=[0]*len(samples)
calls=[0]*len(samples)
homRs=[0]*len(samples)
hets=[0]*len(samples)
homAs=[0]*len(samples)

for line in VCF:
	if line.startswith('#'): continue
	line=line.strip().split('\t')
	if "FAIL" in line[6]: continue
	if "CpGRep" in line[6]: continue
	if line[3] not in ['A','C','G','T']: continue
	if line[4] not in ['.','A','C','G','T']: continue
	INFO=line[7].split(';')
	f=dict(s.split('=') for s in INFO)
	#if int(f['AN'])<50: continue
	for i in range(0,len(samples)):
		GT=line[i+9]
		if GT[:3]=='./.': nocalls[i]+=1
		else: 
			calls[i]+=1
			if GT[:3]=='0/0': homRs[i]+=1
			elif GT[:3]=='0/1': hets[i]+=1
			elif GT[:3]=='1/1': homAs[i]+=1

output = open(filename + '_HetPerInd.txt', 'w')

if len(sys.argv)>2:
	output.write('chromo\tnocalls_%s\tcalls_%s\thomRs_%s\thomAs_%s\thets_%s\n' % ('\tnocalls_'.join(samples), '\tcalls_'.join(samples), '\thomRs_'.join(samples), '\thomAs_'.join(samples), '\thets_'.join(samples)) )
	output.write('%s\t%s\t%s\t%s\t%s\t%s\n' % (chromo, '\t'.join(map(str,nocalls)), '\t'.join(map(str,calls)), '\t'.join(map(str,homRs)), '\t'.join(map(str,homAs)), '\t'.join(map(str,hets))) )
else:
	output.write('nocalls_%s\tcalls_%s\thomRs_%s\thomAs_%s\thets_%s\n' % ('\tnocalls_'.join(samples), '\tcalls_'.join(samples), '\thomRs_'.join(samples), '\thomAs_'.join(samples), '\thets_'.join(samples)) )
	output.write('%s\t%s\t%s\t%s\t%s\n' % ('\t'.join(map(str,nocalls)), '\t'.join(map(str,calls)), '\t'.join(map(str,homRs)), '\t'.join(map(str,homAs)), '\t'.join(map(str,hets))) )
	
output.close()
VCF.close()

exit()
