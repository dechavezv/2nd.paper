'''

USAGE: python HetPerInd_v8.py [yourfile.vcf or yourfile.vcf.gz]

'''

import sys
import gzip
import re

infile=sys.argv[1]

if infile.endswith(".gz") or infile.endswith(".GZ"):
	VCF=gzip.open(infile, 'r')
	filename=infile[:-7]
elif infile.endswith(".vcf") or infile.endswith(".VCF"):	
	VCF=open(infile, 'r')
	filename=infile[:-4]
else:
	print "You must supply a VCF file as input."

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
	if "FAIL" in line[6] or "LowQual" in line[6]: continue
#	if "PASS" not in line[6]: continue
	for i in range(0,len(samples)):
		GT=line[i+9]
		if GT=='.': nocalls[i]+=1
		else: 
			calls[i]+=1
			if GT.split(':')[0]=='0/0': homRs[i]+=1
			elif GT.split(':')[0]=='0/1': hets[i]+=1
			elif GT.split(':')[0]=='1/1': homAs[i]+=1

output = open(filename + '_HetPerInd_v8.txt', 'w')

output.write('ind\tcalls\tnocalls\thomR\thomA\thets\n')
for i in range(len(samples)):
	output.write('%s\t%s\t%s\t%s\t%s\t%s\n' % (samples[i],calls[i],nocalls[i],homRs[i],homAs[i],hets[i]) )

output.close()
VCF.close()

exit()
