"""
Usage:
python ./SlidingWindowHet.py [vcf] [window size] [step size] [chromosome/scaffold name]
Windows will be non-overlapping if step size == window size.

"""
from random import randint
import random
import sys
import pysam
import os
import gzip
import numpy
import itertools
try:
    import cPickle as pickle
except:
    import pickle
from decimal import *
getcontext().prec = 8

VCF = gzip.open(sys.argv[1], 'r')

if not os.path.exists("%s.tbi" % sys.argv[1]):
    pysam.tabix_index(sys.argv[1], preset="vcf")
parsevcf = pysam.Tabixfile(sys.argv[1])

samples=[]
for line in VCF:
    if line.startswith('##'):
        pass
    else:
	for i in line.split()[9:]: samples.append(i)
        break
nindiv=len(samples)

window_size = int(sys.argv[2])
step_size = int(sys.argv[3])
chromo = sys.argv[4]
chromo_size={'chr01':122678785,'chr02':85426708,'chr03':91889043,'chr04':88276631,'chr05':88915250,'chr06':77573801,'chr07':80974532,'chr08':74330416,'chr09':61074082,'chr10':69331447,'chr11':74389097,'chr12':72498081,'chr13':63241923,'chr14':60966679,'chr15':64190966,'chr16':59632846,'chr17':64289059,'chr18':55844845,'chr19':53741614,'chr20':58134056,'chr21':50858623,'chr22':61439934,'chr23':52294480,'chr24':47698779,'chr25':51628933,'chr26':38964690,'chr27':45876710,'chr28':41182112,'chr29':41845238,'chr30':40214260,'chr31':39895921,'chr32':38810281,'chr33':31377067,'chr34':42124431,'chr35':26524999,'chr36':30810995,'chr37':30902991,'chr38':23914537,'chrX':123869142}

# If a region is supplied, use those coordinates for start and end positions
# If no region is specified, start position is the first position in the VCF file, and end position is the length of the chromosome

if len(sys.argv)>5:
    start_pos = int(sys.argv[5])
    end_pos = int(sys.argv[6])
else:
    for line in VCF:
        if line[0] != '#':
            start_pos = int(line.strip().split()[1])
            end_pos = chromo_size[chromo]
            break


def checkmono(lst):
    return not lst or lst.count(lst[0]) == len(lst)

def computedPolymor(AF_all,DS_all,sites_passing,sites_present,sites_polymorphic):
        SNPS_values=[]
        #print(AF_all)
        #print(len(AF_all))
        for i in range(len(AF_all)):
		#print(2*AF_all[i]*float(1-AF_all[i]))
                SNPS_values.append(2*AF_all[i]*float(1-AF_all[i]))
	#print(SNPS_values)
	#print(numpy.sum(SNPS_values))
	Polymor=((numpy.sum(SNPS_values)/sites_polymorphic)*1.111111)  
	#print('%s\t%d\t%d\t%s\t%f\t%d' % (chromo,window_start,window_end,str('Diversity'),Polymor,sites_passing))
	SNPS_values2=[]

        for i in range(len(DS_all)):
                if DS_all[i] == '1/1':
                        SNPS_values2.append(float(1))
                elif DS_all[i] == '0/1':
                        SNPS_values2.append(float(0.5))
        Diver=(numpy.sum(SNPS_values2)/sites_polymorphic)
	k = float(Polymor/Diver)
	Qsites=float(sites_passing)/sites_present
        #print('%s\t%d\t%d\t%s\t%f\t%d' % (chromo,window_start,window_end,str('Divergence'),Diver,sites_passing))
	print('%s\t%d\t%d\t%f\t%f\t%f\t%d\t%d\t%d\t%f' % (chromo,window_start,window_end,Polymor,Diver,k,sites_present,sites_passing,sites_polymorphic,Qsites))	

def fetch_and_calc(chromo,start_pos,end_pos):
        AF_all=[]
	DS_all=[]
        SNPS_values=[]
        sites_present,sites_passing,sites_polymorphic=0,0,0

        for line in parsevcf.fetch(chromo,start_pos,end_pos):
                line = line.split('\t')
                sites_present+=1
                if ('FAIL' in line[6]) or ('.' in line[-1]) or ('.' in line[-2]) or ('.' in line[-3]) or ('.' in line[-4]) or ('.' in line[-5]): continue
                sites_passing+=1
                #print(line[-4:])
                if line[4]=='.': continue
                sites_polymorphic+=1
		AF_value = line[7].split(';')
                value=AF_value[0].split('=')
		#print(line)
		#print(value)
		if value[0] == 'ABHet':
			if ('AF' in AF_value[3]):
				Hetvalue=AF_value[3].split('=')
				if Hetvalue[0] == 'AF':
					Hetnumber=Hetvalue[1].split(',') # keep just SNPS
					if len(Hetnumber) > 1: continue # Keep just SNPS
					AF_all.append(float(Hetvalue[1]))
			elif ('AF' in AF_value[2]):
				Hetvalue=AF_value[2].split('=')
				if Hetvalue[0] == 'AF':
					Hetnumber=Hetvalue[1].split(',') # keep just SNPS
					if len(Hetnumber) > 1: continue # Keep just SNPS
					AF_all.append(float(Hetvalue[1]))
		elif value[0] == 'ABHom':
			Altvalue=AF_value[2].split('=')
			if Altvalue[0] == 'AF':
				Altnumber=Altvalue[1].split(',') # keep just SNP
				if len(Altnumber) > 1: continue # Keep just SNPS
				AF_all.append(float(Altvalue[1]))

		DS_value = line[11].split(':')
                value=DS_value[0]
                number=value[1].split(',') # keep just SNPS
                if len(number) > 1: continue # Keep just SNPS
                DS_all.append(value)

        #once you have genotypes, run it through fxn
        #print '%s\t%s\t%s\t%s\t' % (chromo,start_pos,sites_present,sites_passing),
        #if not AF_all: print("No Allele frequencies")
        computedPolymor(AF_all,DS_all,sites_passing,sites_present,sites_polymorphic)

#initialize window start and end coordinates
window_start = start_pos
window_end = start_pos+window_size-1

# calculate stats for window, change window start and end positions
while window_end <= end_pos:

	if window_end < end_pos:
		fetch_and_calc(chromo,window_start,window_end)

		window_start = window_start + step_size + window_size
		window_end = window_start + window_size - 1

	else:
		fetch_and_calc(chromo,window_start,window_end)
		break

else:
	window_end = end_pos
	fetch_and_calc(chromo,window_start,window_end)

VCF.close()
exit()
