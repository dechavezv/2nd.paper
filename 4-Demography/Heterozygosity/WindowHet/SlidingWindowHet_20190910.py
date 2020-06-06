# Script to count number of called genotypes and number of heterozygotes per sample in 
# sliding windows.
# Input file is a single- or multi-sample VCF file that has been filtered (passing sites 
# have "PASS" in the FILTER column) and compressed with gzip/bgzip.
#
# Usage: 
# python ./SlidingWindowHet.py [vcf] [window size] [step size] [chromosome/scaffold name]
#
# Windows will be non-overlapping if step size == window size.
#
# Example: 
# python ./SlidingWindowHet.py input.vcf.gz 100000 10000 chr01

import sys
import pysam
import os
import gzip


# Open input file and make sure the VCF file is indexed (if not, create index)
filename = sys.argv[1]
VCF = gzip.open(filename, 'r')

if not os.path.exists("%s.tbi" % filename):
    pysam.tabix_index(filename, preset="vcf")
parsevcf = pysam.Tabixfile(filename)


# Set variables
window_size = int(sys.argv[2])
step_size = int(sys.argv[3])
chrom = sys.argv[4]


# Generate a dictionary with chromosomes and chromosome lengths
# File "chrom_lengths.txt" is a two-column tab-delimited list of chromosomes and 
# chromosome lengths in the reference genome
## cc=open("chrom_lengths.txt", 'r')
## chrom_size={line.strip().split('\t')[0]:line.strip().split('\t')[1] for line in cc}
## cc.close()

chrom_size={'chr01':122678785,'chr02':85426708,'chr03':91889043,'chr04':88276631,'chr05':88915250,'chr06':77573801,'chr07':80974532,'chr08':74330416,'chr09':61074082,'chr10':69331447,'chr11':74389097,'chr12':72498081,'chr13':63241923,'chr14':60966679,'chr15':64190966,'chr16':59632846,'chr17':64289059,'chr18':55844845,'chr19':53741614,'chr20':58134056,'chr21':50858623,'chr22':61439934,'chr23':52294480,'chr24':47698779,'chr25':51628933,'chr26':38964690,'chr27':45876710,'chr28':41182112,'chr29':41845238,'chr30':40214260,'chr31':39895921,'chr32':38810281,'chr33':31377067,'chr34':42124431,'chr35':26524999,'chr36':30810995,'chr37':30902991,'chr38':23914537,'chrX':123869142}

# Get list of samples from VCF file header
samples=[]
for line in VCF:
    if line.startswith('##'):
        pass
    else:
        for i in line.split()[9:]: samples.append(i)
        break


# Get start and end positions of chromosome
for line in VCF:
    if line[0] != '#':
        start_pos = int(line.strip().split()[1])
        end_pos = int(chrom_size[chrom])
        break


# Create output file
output = open(filename + '_het_%swin_%sstep.txt' % (window_size, step_size), 'w')
output.write('chrom\twindow_start\tsites_total\tcalls_%s\thets_%s\n' % ('\tcalls_'.join(samples), '\thets_'.join(samples)) )


# Fetch a region, ignore sites that fail filters, tally genotype calls and heterozygotes        
def snp_cal(chrom,window_start,window_end):
    print("%s:%s" % (chrom,window_start))
    rows = tuple(parsevcf.fetch(region="%s:%s-%s" % (chrom, window_start, window_end), parser=pysam.asTuple()))    
    sites_total=0
    calls=[0]*len(samples)
    hets=[0]*len(samples)
    for line in rows:
        if line[6]!="PASS": continue
        sites_total+=1
        for i in range(0,len(samples)):
            if line[i+9][:1]=='.': continue
            calls[i]+=1
            GT=line[i+9].split(':')[0]
            if '/' in GT: sp='/'
            if '|' in GT: sp='|'
            if GT.split(sp)[0]!=GT.split(sp)[1]: hets[i]+=1
    output.write('%s\t%s\t%s\t%s\t%s\n' % (chrom,window_start,sites_total,'\t'.join(map(str,calls)),'\t'.join(map(str,hets))) )

# Initialize window start and end coordinates
window_start = start_pos
window_end = start_pos+window_size-1


# Calculate stats for window, update window start and end positions, 
# repeat to end of chromosome
while window_end <= end_pos:    
    if window_end < end_pos:
        snp_cal(chrom,window_start,window_end)
        window_start = window_start + step_size
        window_end = window_start + window_size - 1
    else:
        snp_cal(chrom,window_start,window_end)
        break    
else:
    window_end = end_pos
    snp_cal(chrom,window_start,window_end)


# Close files and exit
VCF.close()
output.close()

exit()


