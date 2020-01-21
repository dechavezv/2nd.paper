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
'SNI1_88_F':34,
'SCA_88_F':49,
'SCZ_88_M':30,
'SMI_88_F':44,
'SNI2_88_F':28,
'SRO_88_F':29,
'SCL_88_F':36,
'GF_SAMO_F':33,
'GF_GOGA_M':54,
'SCA_05_M':42,
'SCL_09_F':39,
'SCZ_08_F':40,
'SMI_08_M':41,
'SNI_00_M':43,
'SRO_08_M':42}

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
def GTfilter(sample,GT_entry):
	field=GT_entry.split(':')
	if field[0]=='./.': return GT_entry
	else:
		if field[3]!='.' and float(field[3])>=20.0 and field[2]!='.' and minD<=int(field[2])<=maxD[sample]: return GT_entry
#		if field[3]!='.' and field[2]!='.': return GT_entry
		else: return './.:' + ':'.join(field[1:])

for line0 in inVCF:

### Write header lines
	if line0.startswith('#'): sys.stdout.write(line0); continue

### For all other lines:
	line=line0.strip().split('\t')

### Site filtering:

### Reference must not be N
	if line[3]=='N': sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), 'FAIL_refN', '\t'.join(line[7:])) ); continue

### Alternate allele must not be <NON_REF>
	if line[4]=='<NON_REF>': sys.stdout.write('%s\t%s\t%s\t%s\t%s\n' % ('\t'.join(line[0:4]), '.', line[5] , 'FAIL_bad_alt', '\t'.join(line[7:])) ); continue

### Only accept sites with minimum QUAL value (min QUAL 30 for variant sites)
	if line[5]=='.': sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), 'FAIL_QUAL', '\t'.join(line[7:])) ); continue
	if float(line[5])<30.0: sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), 'FAIL_QUAL', '\t'.join(line[7:])) ); continue

## Access INFO field data
	INFO=line[7].split(';')
	f=dict(s.split('=') for s in INFO)

### Only accept sites that are monomorphic or simple SNPs
	if f['VariantType'] not in ('NO_VARIATION', 'SNP'): sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), 'FAIL_bad_mut', '\t'.join(line[7:])) ); continue

### Only accept sites within permissible depth range
#	if int(re.search('(?<=DP=)[^;]+', INFO).group(0))>396 or int(re.search('(?<=DP=)[^;]+', INFO).group(0))<???: sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), 'FAIL_DP', '\t'.join(line[7:])) ); continue
	if int(f['DP'])>396: sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), 'FAIL_DP', '\t'.join(line[7:])) ); continue

### For variant sites: check strand bias
# Note: previous filter was "only accept sites with QUAL>=50, and at least 2 observations on each of the F and R strands for alternate alleles"
	if line[4]!='.':
#		if float(f['FS'])>60.0 or float(f['SOR'])>4.0: sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), 'FAIL_altstrand', '\t'.join(line[7:])) ); continue
		if float(f['FS'])>60.0: sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), 'FAIL_altstrand', '\t'.join(line[7:])) ); continue
#		if float(f['SOR'])>4.0: sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), 'FAIL_altstrand', '\t'.join(line[7:])) ); continue
### Get AB value for use in later het. filtering
		if 'ABHet' in f: AB=float(f['ABHet'])

### Genotype filtering:

	missing,excesshet=0,0

	GT_list=[]
	for i in range(0,len(samples)):
		GT=GTfilter(samples[i],line[i+9])
#		GT=line[i+9]
		if GT[:3]=='./.': 
			missing+=1
			GT_list.append(GT)
		else:
			if GT[:3]=='0/1':
				excesshet+=1
				if 0.2<=AB<=0.8: GT_list.append(GT)
#				GT_list.append(GT)
				else: 
					GT_list.append('./.' + GT[3:])
					missing+=1
			else: GT_list.append(GT)

### Filter out sites with more than 25% missing/failing genotypes, and more than 66% het. genotypes
# Note: previous filter was for > 2/8 missing and > 5/8 hets
	if missing>5: sys.stdout.write('%s\t%s\t%s\t%s\n' % ('\t'.join(line[0:6]), 'FAIL_missing', '\t'.join(line[7:9]), '\t'.join(GT_list)) ); continue
	if excesshet>10: sys.stdout.write('%s\t%s\t%s\t%s\n' % ('\t'.join(line[0:6]), 'FAIL_excesshet', '\t'.join(line[7:9]), '\t'.join(GT_list)) ); continue

### Recalculate INFO fields
	REF=2*[x[:3] for x in GT_list].count('0/0') + [x[:3] for x in GT_list].count('0/1')
	ALT=2*[x[:3] for x in GT_list].count('1/1') + [x[:3] for x in GT_list].count('0/1')	
	f['AC']=ALT
	f['AN']=REF+ALT
	f['AF']=round(float(ALT)/(float(REF)+float(ALT)), 4)

### Write out new line
	sys.stdout.write('%s\t%s\t%s\t%s\n' % ('\t'.join(line[0:7]), ';'.join('{0}={1}'.format(key, val) for key, val in sorted(f.items())), line[8], '\t'.join(GT_list)) )
		

inVCF.close()
#outVCF.close()

exit()

