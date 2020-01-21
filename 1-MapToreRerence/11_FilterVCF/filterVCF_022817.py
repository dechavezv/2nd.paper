'''

Input = raw VCF
Output = filtered VCF prints to screen
- Filtered sites are marked as FAIL_? in the 7th column
- Sites that pass go on to genotype filtering
- Filtered out genotypes are changed to './.', all others reported

Possible usage:

MYDIR=/u/home/j/jarobins/project-rwayne
TABIX=${MYDIR}/utils/programs/htslib-1.3.1/tabix
INTERSECTBED=${MYDIR}/utils/programs/bedtools2/bin/intersectBed
BGZIP=${MYDIR}/utils/programs/htslib-1.3.1/bgzip
CPGandREPEATS=${MYDIR}/utils/beds/CpG_and_repeat_filter_cf31_fixed_sorted.bed

python ${MYDIR}/utils/scripts/filtervcf/filterVCF_010717.py fox_15_joint_chr38_trim_annot.vcf.gz | \
${INTERSECTBED} -v -sorted -header -a stdin -b ${CPGandREPEATS} | \
${BGZIP} > fox_15_joint_chr38_trim_annot_filtered.vcf.gz; \
${TABIX} -p vcf fox_15_joint_chr38_trim_annot_filtered.vcf.gz

NOTE: Will recalculate AC, AF, AN.

'''

import sys
import gzip
import re

vcf_file = sys.argv[1]
inVCF = gzip.open(vcf_file, 'r')

#outVCF=open(vcf_file[:-7]+'_filtered.vcf', 'w')

minD=6

maxD={
'ALG1':42,
'CL025':39,
'CL039':14,
'CL055':44,
'CL061':39,
'CL062':40,
'CL065':39,
'CL067':48,
'CL075':40,
'CL141':41,
'CL149':39,
'CL152':40,
'CL175':41,
'CL189':42,
'CLA1':48,
'CRO1':20,
'ETH1':22,
'IRA1':48,
'ITL1':15,
'ITL2':24,
'MEX1':44,
'PTG1':44,
'RED1':50,
'RKW119':64,
'RKW2455':46,
'RKW2515':43,
'RKW2518':64,
'RKW2523':56,
'RKW2524':61,
'SPN1':40,
'TIB1':49,
'XJG1':51,
'YNP1':48,
'YNP2':43,
'YNP3':35}

samples=[]
for line in inVCF:
	if line.startswith('##'):
		pass
	else:
		for i in line.split()[9:]: samples.append(i)
		break

inVCF.seek(0)

# Filter to check for excess heterozygosity
#def HETfilter(sample,GT_entry):
#	field=GT_entry.split(':')
#	if field[0]=='0/1': return '.'

# Filter to be applied to individual genotypes
# GQpos is the position of the GQ in FORMAT (varies)
def GTfilter(sample,GT_entry,GQpos):
	field=GT_entry.split(':')
	if field[0]=='./.': return GT_entry
	else:
#		if field[GQpos]!='.' and float(field[GQpos])>=20.0 and field[2]!='.' and minD<=int(field[2]): return GT_entry
		if field[GQpos]!='.' and float(field[GQpos])>=20.0 and field[2]!='.' and minD<=int(field[2])<=maxD[sample]: return GT_entry
#		if field[3]!='.' and field[2]!='.': return GT_entry
		else: return './.:' + ':'.join(field[1:])

### Write header lines
# Add new header lines for filters being added - for GATK compatibility
for line0 in inVCF:
	if line0.startswith('#'):
		if line0.startswith('##FORMAT'):
#			sys.stdout.write('##FILTER=<ID=FAIL_refN,Description="Low quality">\n##FILTER=<ID=FAIL_badAlt,Description="Low quality">\n##FILTER=<ID=FAIL_QUAL,Description="Low quality">\n##FILTER=<ID=FAIL_badMut,Description="Low quality">\n##FILTER=<ID=FAIL_DP,Description="Low quality">\n##FILTER=<ID=FAIL_altStrand,Description="Low quality">\n##FILTER=<ID=FAIL_missing,Description="Low quality">\n##FILTER=<ID=FAIL_excessHet,Description="Low quality">\n') 
			sys.stdout.write('##FILTER=<ID=FAIL_refN,Description="Low quality">\n##FILTER=<ID=FAIL_badAlt,Description="Low quality">\n##FILTER=<ID=FAIL_noQUAL,Description="Low quality">\n##FILTER=<ID=FAIL_noGQ,Description="Low quality">\n##FILTER=<ID=FAIL_noGT,Description="Low quality">\n##FILTER=<ID=WARN_mutType,Description="Low quality">\n##FILTER=<ID=WARN_missing,Description="Low quality">\n') 
			sys.stdout.write(line0)
			break
		else: sys.stdout.write(line0)
	
for line0 in inVCF:
	if line0.startswith('#'): 
		sys.stdout.write(line0); continue

### For all other lines:
	line=line0.strip().split('\t')

### Site filtering:
# Keep any filters that have already been applied (like CpGandRepeats)
	filter=[]
	if line[6]!='PASS': 
		if line[6]=='FAIL_CpGRep':
			filter.append(line[6])
		else:
			sys.stdout.write(line0); continue

### Reference must not be N
	if line[3]=='N': 
		filter.append('FAIL_refN')
		sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), ';'.join(filter), '\t'.join(line[7:])) ); continue

### Alternate allele must not be multiallelic or <NON_REF>
	if ',' in line[4]: 
		filter.append('FAIL_badAlt')
		sys.stdout.write('%s\t%s\t%s\t%s\t%s\n' % ('\t'.join(line[0:4]), '.', line[5] , ';'.join(filter), '\t'.join(line[7:])) ); continue

	if line[4]=='<NON_REF>': 
		filter.append('FAIL_badAlt')
		sys.stdout.write('%s\t%s\t%s\t%s\t%s\n' % ('\t'.join(line[0:4]), '.', line[5] , ';'.join(filter), '\t'.join(line[7:])) ); continue

### Only accept sites with minimum QUAL value (min QUAL 30 for variant sites)
	if line[5]=='.': 
		filter.append('FAIL_noQUAL')
		sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), ';'.join(filter), '\t'.join(line[7:])) ); continue
#	if float(line[5])<30.0: 
#		filter.append('FAIL_QUAL')
#		sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), ';'.join(filter), '\t'.join(line[7:])) ); continue

## Access INFO field annotations
	INFO=line[7].split(';')
	f=dict(s.split('=') for s in INFO)

### Only accept sites that are monomorphic or simple SNPs
	if f['VariantType'] not in ('NO_VARIATION', 'SNP'): 
		filter.append('WARN_mutType')
#		sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), ';'.join(filter), '\t'.join(line[7:])) ); continue

### Only accept sites within permissible depth range
#	if int(re.search('(?<=DP=)[^;]+', INFO).group(0))>396 or int(re.search('(?<=DP=)[^;]+', INFO).group(0))<???: sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), 'FAIL_DP', '\t'.join(line[7:])) ); continue
#	if int(f['DP'])>396: 
#		filter.append('FAIL_DP')
#		sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), ';'.join(filter), '\t'.join(line[7:])) ); continue

### For variant sites: check strand bias
# Note: previous filter was "only accept sites with QUAL>=50, and at least 2 observations on each of the F and R strands for alternate alleles"
#	if line[4]!='.':
#		if float(f['FS'])>60.0 or float(f['SOR'])>4.0: sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), 'FAIL_altstrand', '\t'.join(line[7:])) ); continue
#		if float(f['FS'])>60.0: 
#			filter.append('FAIL_altStrand')
#			sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), ';'.join(filter), '\t'.join(line[7:])) ); continue
#		if float(f['SOR'])>4.0: sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), 'FAIL_altstrand', '\t'.join(line[7:])) ); continue
### Get AB value for use in later het. filtering
#		if 'ABHet' in f: AB=float(f['ABHet'])

### Get the position of GQ value in genotype fields

#	formatfields=line[8].split(':')
#	if f['VariantType']=='NO_VARIATION':
#		GQpos=formatfields.index('RGQ')
#	if f['VariantType']=='SNP':
#		GQpos=formatfields.index('GQ')

	if 'GQ' in line[8]: 
		formatfields=line[8].split(':')
		GQpos=[formatfields.index(x) for x in formatfields if 'GQ' in x][0]
	else: 
		filter.append('FAIL_noGQ')
		sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), ';'.join(filter), '\t'.join(line[7:])) ); continue

### Genotype filtering:

	missing,excesshet=0,0

	GT_list=[]
	for i in range(0,len(samples)):
		GT=GTfilter(samples[i],line[i+9],GQpos)
#		GT=line[i+9]
		if GT[:3]=='./.': 
			missing+=1
			GT_list.append(GT)
		else:
			if GT[:3]=='0/1':
				excesshet+=1
#				if 0.2<=AB<=0.8: GT_list.append(GT)
				GT_list.append(GT)
#				else: 
#					GT_list.append('./.' + GT[3:])
#					missing+=1
			else: GT_list.append(GT)

### Filter out sites with more than 25% missing/failing genotypes, and more than 66% het. genotypes
# Note: previous filter was for > 2/8 missing and > 5/8 hets
	if missing>0.2*len(samples): 
		filter.append('WARN_missing')
#		sys.stdout.write('%s\t%s\t%s\t%s\n' % ('\t'.join(line[0:6]), ';'.join(filter), '\t'.join(line[7:9]), '\t'.join(GT_list)) ); continue
#	if excesshet>10: 
#		filter.append('FAIL_excessHet')
#		sys.stdout.write('%s\t%s\t%s\t%s\n' % ('\t'.join(line[0:6]), ';'.join(filter), '\t'.join(line[7:9]), '\t'.join(GT_list)) ); continue

### Recalculate INFO fields
	REF=2*[x[:3] for x in GT_list].count('0/0') + [x[:3] for x in GT_list].count('0/1')
	ALT=2*[x[:3] for x in GT_list].count('1/1') + [x[:3] for x in GT_list].count('0/1')

	if REF+ALT==0:
		filter.append('FAIL_noGT')
		sys.stdout.write('%s\t%s\t%s\t%s\n' % ('\t'.join(line[0:6]), ';'.join(filter), '\t'.join(line[7:9]), '\t'.join(GT_list)) ); continue
	
	f['AC']=ALT
	f['AN']=REF+ALT
	f['AF']=round(float(ALT)/(float(REF)+float(ALT)), 4)

	if filter==[]: filter.append('PASS')

### Write out new line
	sys.stdout.write('%s\t%s\t%s\t%s\t%s\n' % ('\t'.join(line[0:6]), ';'.join(filter), ';'.join('{0}={1}'.format(key, val) for key, val in sorted(f.items())), line[8], '\t'.join(GT_list)) )
		

inVCF.close()
#outVCF.close()

exit()

