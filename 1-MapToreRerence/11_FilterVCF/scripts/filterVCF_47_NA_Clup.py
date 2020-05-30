'''
Input = raw VCF
Output = filtered VCF prints to screen
- Filtered sites are marked as FAIL_? in the 7th column
- Sites that pass go on to genotype filtering
- Filtered out genotypes are changed to './.', all others reported

Possible usage:

SCRIPT=filterVCF_MW.py 
python ${SCRIPT} myfile.vcf.gz | bgzip > myfile_filtered.vcf.gz
tabix -p vcf myfile_filtered.vcf.gz

'''

import sys
import gzip
import re
import scipy.stats as ss


vcf_file = sys.argv[1]
VCF = gzip.open(vcf_file, 'r')


#Mean, Min depth (1/3x mean) and max depth (2x mean)
meanD={'ALG1':24.5854,'CL025':22.8138,'CL055':25.1848,'CL061':23.0609,'CL062':23.9047,'CL065':22.8952,'CL067':24.2528,'CL075':23.8148,'CL141':23.6539,'CL152':23.4563,'CL175':24.4404,'CL189':23.9698,'Clup1185':29.7947,'Clup1694':23.5135,'Clup2491':20.7281,'Clup4267':54.5693,'Clup5161':23.6573,'Clup5558':34.4567,'Clup6338':25.5764,'Clup6459':19.5243,'ClupRKW3624':21.0763,'ClupRKW3637':20.2953,'ClupRKW7526':21.0938,'Clup_SRR8049197':11.3478,'Cruf_SRR8049200':3.04022,'MEX1':23.2251,'RED1':27.1519,'RKW119':19.859,'RKW2455':24.2559,'RKW2515':23.6905,'RKW2518':21.3784,'RKW2523':22.9624,'RKW2524':20.3418,'RKW7619':31.361,'RKW7639':50.0727,'RKW7640':48.9986,'RKW7649':36.2968,'SRR7976407_Algoquin':0.617102,'SRR7976417_red':26.3278,'SRR7976421_570M_YNP':23.3463,'SRR7976422_569F_YNP':24.6326,'SRR7976423_302M_YNP':6.61073,'SRR7976431_Mexican_NewM':22.5215,'SRR7976432_Minesota':23.5243,'YNP2':24.1811,'YNP3':19.1434}
minD={'ALG1':8.19515,'CL025':7.60459,'CL055':8.39495,'CL061':7.68696,'CL062':7.96824,'CL065':7.63174,'CL067':8.08428,'CL075':7.93828,'CL141':7.88462,'CL152':7.81877,'CL175':8.1468,'CL189':7.98993,'Clup1185':9.93156,'Clup1694':7.83782,'Clup2491':6.90937,'Clup4267':18.1898,'Clup5161':7.88576,'Clup5558':11.4856,'Clup6338':8.52547,'Clup6459':6.50811,'ClupRKW3624':7.02543,'ClupRKW3637':6.76508,'ClupRKW7526':7.03127,'Clup_SRR8049197':3.7826,'Cruf_SRR8049200':1.01341,'MEX1':7.74172,'RED1':9.05062,'RKW119':6.61966,'RKW2455':8.0853,'RKW2515':7.89684,'RKW2518':7.12612,'RKW2523':7.65412,'RKW2524':6.78059,'RKW7619':10.4537,'RKW7639':16.6909,'RKW7640':16.3329,'RKW7649':12.0989,'SRR7976407_Algoquin':0.205701,'SRR7976417_red':8.77594,'SRR7976421_570M_YNP':7.7821,'SRR7976422_569F_YNP':8.21085,'SRR7976423_302M_YNP':2.20358,'SRR7976431_Mexican_NewM':7.50718,'SRR7976432_Minesota':7.84142,'YNP2':8.06037,'YNP3':6.38113}
maxD={'ALG1':49.1709,'CL025':45.6275,'CL055':50.3697,'CL061':46.1217,'CL062':47.8094,'CL065':45.7904,'CL067':48.5057,'CL075':47.6297,'CL141':47.3077,'CL152':46.9126,'CL175':48.8808,'CL189':47.9396,'Clup1185':59.5893,'Clup1694':47.0269,'Clup2491':41.4562,'Clup4267':109.139,'Clup5161':47.3146,'Clup5558':68.9133,'Clup6338':51.1528,'Clup6459':39.0487,'ClupRKW3624':42.1526,'ClupRKW3637':40.5905,'ClupRKW7526':42.1876,'Clup_SRR8049197':22.6956,'Cruf_SRR8049200':6.08045,'MEX1':46.4503,'RED1':54.3037,'RKW119':39.718,'RKW2455':48.5118,'RKW2515':47.381,'RKW2518':42.7567,'RKW2523':45.9247,'RKW2524':40.6835,'RKW7619':62.722,'RKW7639':100.145,'RKW7640':97.9972,'RKW7649':72.5936,'SRR7976407_Algoquin':1.2342,'SRR7976417_red':52.6556,'SRR7976421_570M_YNP':46.6926,'SRR7976422_569F_YNP':49.2651,'SRR7976423_302M_YNP':13.2215,'SRR7976431_Mexican_NewM':45.0431,'SRR7976432_Minesota':47.0485,'YNP2':48.3622,'YNP3':38.2868}

# Get list of samples in VCF file
samples=[]
for line in VCF:
    if line.startswith('##'):
        pass
    else:
        for i in line.split()[9:]: samples.append(i)
        break


# Go back to beginning of file
VCF.seek(0)

# Filter to be applied to individual genotypes
### sample is the sample name
### GT_entry is the entire genotype entry for that individual
### ADpos is the position of the AD in FORMAT (typically GT:AD:DP:GQ)
### DPpos is the position of the DP in FORMAT
### GQpos is the position of the GQ in FORMAT
def GTfilter(sample, GT_entry, ADpos, DPpos, GQpos):
    if GT_entry[:1]=='.' : return GT_entry
    else:
        gt=GT_entry.split(':')
        if gt[0] in ('0/0','0/1','1/1') and gt[GQpos]!='.' and gt[DPpos]!='.':
            DP=int(gt[DPpos])
            GQ=float(gt[GQpos])
            if GQ>=0.0 and minD[sample]<=DP<=maxD[sample]:
                REF=float(gt[ADpos].split(',')[0])
                AB=float(REF/DP)
                if gt[0]=='0/0':
                    if AB>=0.9: return GT_entry
                    else: return './.:' + ':'.join(gt[1:])
                elif gt[0]=='0/1':
                    if 0.2<=AB<=0.8: return GT_entry
                    else: return './.:' + ':'.join(gt[1:])
                elif gt[0]=='1/1':
                    if AB<=0.1: return GT_entry
                    else: return './.:' + ':'.join(gt[1:])
                else: './.:' + ':'.join(gt[1:])
            else: return './.:' + ':'.join(gt[1:])
        else: return './.:' + ':'.join(gt[1:])


# Write header lines
### Add new header lines for filters being added - for GATK compatibility
for line0 in VCF:
    if line0.startswith('#'):
        if line0.startswith('##FORMAT'):
            sys.stdout.write('##FILTER=<ID=FAIL_refN,Description="Low quality">\n')
            sys.stdout.write('##FILTER=<ID=FAIL_multiAlt,Description="Low quality">\n')
            sys.stdout.write('##FILTER=<ID=FAIL_badAlt,Description="Low quality">\n')
            sys.stdout.write('##FILTER=<ID=FAIL_noQUAL,Description="Low quality">\n')
            sys.stdout.write('##FILTER=<ID=FAIL_noINFO,Description="Low quality">\n')
            sys.stdout.write('##FILTER=<ID=FAIL_mutType,Description="Low quality">\n')
            sys.stdout.write('##FILTER=<ID=FAIL_noGQi,Description="Low quality">\n')
            sys.stdout.write('##FILTER=<ID=FAIL_noDPi,Description="Low quality">\n')
            sys.stdout.write('##FILTER=<ID=FAIL_noADi,Description="Low quality">\n')
            sys.stdout.write(line0)
            break
        else: sys.stdout.write(line0)


# Go through VCF file line by line to apply filters
for line0 in VCF:
    if line0.startswith('#'):
        sys.stdout.write(line0); continue

### For all other lines:
    line=line0.strip().split('\t')

### Site filtering:
### Keep any filters that have already been applied
    filter=[]
    if line[6] not in ('.', 'PASS'):
        filter.append(line[6])

### Reference must not be N
    if line[3]=='N':
        filter.append('FAIL_refN')
        sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), ';'.join(filter), '\t'.join(line[7:])) ) ; continue

### Alternate allele must not be multiallelic or <NON_REF>
    if ',' in line[4]:
        filter.append('FAIL_multiAlt')

    if '<NON_REF>' in line[4]:
        filter.append('FAIL_badAlt')

### Must have a valid QUAL
    if line[5]=='.':
        filter.append('FAIL_noQUAL')

### Access INFO field annotations
    if ';' in line[7]:
        INFO=line[7].split(';')
        d=dict(x.split('=') for x in INFO)
    else:
        INFO=line[7]
        if '=' in INFO:
            d={INFO.split('=')[0]:INFO.split('=')[1]}
        else: filter.append('FAIL_noINFO')

### Only accept sites that are monomorphic or simple SNPs
    if 'VariantType' not in d or d['VariantType'] not in ('NO_VARIATION', 'SNP'):
        filter.append('FAIL_mutType')

### Get the position of AD, DP, GQ value in genotype fields
    if 'AD' in line[8]:
        ADpos=line[8].split(':').index('AD')
    else: filter.append('FAIL_noADi')

    if 'DP' in line[8]:
        DPpos=line[8].split(':').index('DP')
    else: filter.append('FAIL_noDPi')

    if 'GQ' in line[8]:
        ff=line[8].split(':')
        GQpos=[ff.index(x) for x in ff if 'GQ' in x][0]
    else: filter.append('FAIL_noGQi')

### If any filters failed, write out line and continue
    if filter!=[]:
        sys.stdout.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), ';'.join(filter), '\t'.join(line[7:])) ) ; continue

### Genotype filtering:
    GT_list=[]
    for i in range(0,len(samples)):
        GT=GTfilter(samples[i],line[i+9],ADpos,DPpos,GQpos)
        GT_list.append(GT)
    if filter==[]:
        filter.append('PASS')

### Write out new line
    sys.stdout.write('%s\t%s\t%s\t%s\t%s\n' % ('\t'.join(line[0:6]), ';'.join(filter), ';'.join('{0}={1}'.format(key, val) for key, val in sorted(d.items())), line[8], '\t'.join(GT_list)) )


# Close files and exit
VCF.close()
exit()
