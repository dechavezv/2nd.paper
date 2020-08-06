'''
Input = raw VCF
Output = filtered VCF
- Filtered sites are marked as FAIL in the 7th column
- Sites that pass go on to genotype filtering
- Filtered out genotypes are changed to '.', all others reported

usage:

python Filter_VCF_All_Canids_Wild_dogsv2.py infile_gvcf.vcf.gz chr01
'''

import sys
import gzip
import re
import numpy

vcf_file = sys.argv[1]
inVCF = gzip.open(vcf_file, 'r')

outVCF=open(vcf_file[:-7]+'_Testig_filtered_v4.vcf', 'w')

minD=4
maxD={'Ananku':21,'Ethiopian':19,'Dhole':32,'GoldenW':40,'GrayF':40,'Kenyan':27,'Coyote':40,'AndeanF':18,'African':37,'Jackal':46,'Kenya_WGF20':26,'GrayW':41}
Overall_minD={'chr01':115,'chr02':98.55,'chr03':111,'chr04':111,'chr05':109,'chr06':101,'chr07':105,'chr08':91,'chr09':98,'chr10':99,'chr11':57,'chr12':100,'chr13':115,'chr14':51,'chr15':38.2,'chr16':84,'chr17':107,'chr18':111,'chr19':103,'chr20':114,'chr21':95,'chr22':97,'chr23':107,'chr24':101,'chr25':96,'chr26':104,'chr27':69,'chr28':91,'chr29':95,'chr30':96,'chr31':84,'chr32':90,'chr33':110,'chr34':110,'chr35':42.5,'chr36':109,'chr37':107,'chr38':107,'chrX':92}
Overall_maxD={'chr01':289,'chr02':294,'chr03':289,'chr04':283,'chr05':280,'chr06':289,'chr07':272,'chr08':272,'chr09':284,'chr10':273,'chr11':338.65,'chr12':277,'chr13':278,'chr14':844,'chr15':266,'chr16':449,'chr17':268,'chr18':275,'chr19':269,'chr20':280,'chr21':270,'chr22':273,'chr23':276,'chr24':281,'chr25':283,'chr26':285,'chr27':269,'chr28':281,'chr29':271,'chr30':274,'chr31':258,'chr32':269,'chr33':272,'chr34':280,'chr35':2826,'chr36':270,'chr37':280,'chr38':272,'chr39':259}

chromosome=sys.argv[2]

samples=[]
for line in inVCF:
	if line.startswith('##'):
		pass
	else:
		for i in line.split()[9:]: samples.append(i)
		break

inVCF.seek(0)

# Filter to be applied to individual genotypes
def GTfilter(sample,GT_entry):
	if (GT_entry=='.') or ('./.' in GT_entry): return '.'
	else:
		try:
			field=GT_entry.split(':')          
			if '.' in field[2]: return '.'	
                        if '.' in field[3]: return '.'
			elif float(field[3])<20.0: return '.'
			elif int(field[2])<minD: return '.'
			elif int(field[2])>maxD[sample]: return '.'
			else: return field[0]
		except IndexError:
                  	return '.'

def Coverage(sample,DP_entry):
        if (DP_entry=='.') or ('./.' in DP_entry): return '0'
        else:
        	try:
        		field=DP_entry.split(':')
                	if '.' in field[2]: return '0'
                	else: return field[2]
		except IndexError:
			return '0'
                
for line0 in inVCF:

### Write header lines
	if line0.startswith('#'): outVCF.write(line0); continue
	
### For all other lines:
	line=line0.strip().split('\t')
	INFO=line[7]
	element = line[8]
	A = element.split(':')	
	if A[2] != 'DP' or A[2] == '.': pass
### Site filtering
### For homog refer accept QUAL>=20. For variant sites use the normilized version of QUAL (QD; http://gatkforums.broadinstitute.org/gatk/discussion/7258/math-notes-understanding-the-qual-score-and-its-limitations). 
### Only accept sites with QD>=20, and permissible depth range
	if line[5]!='.':
		GQ=float(line[5])
		if line[4]!='.' and 'QD' not in INFO: outVCF.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), 'FAIL_Missing_AD', '\t'.join(line[7:])) ); continue	
		if line[4]=='.' and GQ<20.0: outVCF.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), 'FAIL_GQ', '\t'.join(line[7:])) ); continue
		if 'QD' in INFO and line[4]!='.' and float(re.search('(?<=QD=)[^;]+', INFO).group(0))<2: outVCF.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), 'FAIL_QD', '\t'.join(line[7:])) ); continue
		#if int(re.search('(?<=DP=)[^;]+', INFO).group(0))>Overall_maxD[chromosome] or int(re.search('(?<=DP=)[^;]+', INFO).group(0))<Overall_minD[chromosome]: outVCF.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), 'FAIL_DP', '\t'.join(line[7:])) ); continue
	
### Filter out sites with more than 10 missing/failing genotypes, and more than 5 het. genotypes
	missing,excesshets=0,0
	for i in range(0,len(samples)):
		if line[4] == '.': continue
		if GTfilter(samples[i], line[i+9])=='.': missing+=1 
	if missing>7: outVCF.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), 'FAIL_missing', '\t'.join(line[7:])) ); continue

### Filter out sites with less than 10 averall Coverage
	if line[4]!='.':
		DP_all=[]
        	for i in range(0,len(samples)):
			DP=Coverage(samples[i],line[i+9])
			DP_all.append(float(DP))
		#Overall_DP = numpy.sum(DP_all)
		#print('overall' + '\t' + str(Overall_DP))
		#if Overall_DP < 10: outVCF.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), 'FAIL_OverallDP', '\t'.join(line[7:])) ); continue


### Genotype filtering
### Write line contents up to first genotype
	outVCF.write('%s' % '\t'.join(line[:9]))
### Check each genotype to see if it passes depth and quality filters, plus overall coverage 
	for i in range(0,len(samples)):
		if line[4] == '.': continue
		GT=GTfilter(samples[i],line[i+9])
		if GT=='.': outVCF.write('\t.')
		elif GT: outVCF.write('\t%s' % line[i+9])
		#elif GT=='[0-9]/[0-9]': print(GT)
		#elif GT=='[0-9]/[0-9]': outVCF.write('\t%s' % line[i+9])

### End the line
	outVCF.write('\n')

inVCF.close()
outVCF.close()

exit()
