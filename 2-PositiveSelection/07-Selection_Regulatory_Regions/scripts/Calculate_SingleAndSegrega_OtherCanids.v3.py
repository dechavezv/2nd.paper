"""
Usage:
python ../scripts/Calculate_Singletones_BD_and_MW.py chr_all_filtered.vcf.gz 1800 2800 chr01  > outfile.txt

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

start_pos = int(sys.argv[2])
end_pos = int(sys.argv[3])
chromo = sys.argv[4]
EnsemblID = sys.argv[5]
chromo_size={'chr01':122678785,'chr02':85426708,'chr03':91889043,'chr04':88276631,'chr05':88915250,'chr06':77573801,'chr07':80974532,'chr08':74330416,'chr09':61074082,'chr10':69331447,'chr11':74389097,'chr12':72498081,'chr13':63241923,'chr14':60966679,'chr15':64190966,'chr16':59632846,'chr17':64289059,'chr18':55844845,'chr19':53741614,'chr20':58134056,'chr21':50858623,'chr22':61439934,'chr23':52294480,'chr24':47698779,'chr25':51628933,'chr26':38964690,'chr27':45876710,'chr28':41182112,'chr29':41845238,'chr30':40214260,'chr31':39895921,'chr32':38810281,'chr33':31377067,'chr34':42124431,'chr35':26524999,'chr36':30810995,'chr37':30902991,'chr38':23914537,'chrX':123869142}

def checkmono(lst):
    return not lst or lst.count(lst[0]) == len(lst)

AWD_single = []
SegregationSites = []

sites_present,sites_passing=0,0
for line in parsevcf.fetch(chromo,start_pos,end_pos):
	line = line.split('\t')
	sites_present+=1
	# Get Singletones bush dog
	if ('FAIL' in line[6]): continue
	sites_passing+=1
	for i in range(1,14):
		#if i == 2 or i == 8: continue #if you want to exclude BushDog=2 and GrayFox=8
		if i == 11 or i == 8: continue #if you want to exclude ManedWolf=2 and GrayFox=8
		else:
			field=line[-i].split(':')  			
			if ('1/1' in field[0]):# or ('2/2' in field[0]) or ('1/2' in field[0]):
				SegregationSites.append(float(1))
			elif ('0/1' in field[0]):# or ('0/2' in field[0]):
				SegregationSites.append(float(0.5))


	#Calculate Singletones
	#All sites homozygous reference
        #If two alleles add 1
	if ('.' in line[-1] or '0/0' in line[-1]) and ('.' in line[-2] or '0/0' in line[-2]) and ('.' in line[-3] or '0/0' in line[-3]) and ('.' in line[-4] or '0/0' in line[-4]) and  ('.' in line[-5] or '0/0' in line[-5]) and  ('.' in line[-6] or '0/0' in line[-6]) and ('.' in line[-7] or '0/0' in line[-7]) and  ('.' in line[-10] or '0/0' in line[-10]) and ('.' in line[-9] or '0/0' in line[-9]) and ('.' in line[-8] or '0/0' in line[-8]) and  ('.' in line[-11] or '0/0' in line[-11]) and  ('.' in line[-12] or '0/0' in line[-12]) and  ('.' in line[-13] or '0/0' in line[-13]):
		AWD_single.append(float(0))

	#Singletone BD and everything else homozygous reference
	# If two alleles add 1
	elif ('.' in line[-1] or '0/0' in line[-1]) and ('.' in line[-2] or '0/0' in line[-2]) and ('.' in line[-3] or '0/0' in line[-3]) and ('.' in line[-4] or '0/0' in line[-4]) and  ('.' in line[-5] or '0/0' in line[-5]) and  ('.' in line[-6] or '0/0' in line[-6]) and ('.' in line[-7] or '0/0' in line[-7]) and  ('.' in line[-10] or '0/0' in line[-10]) and ('.' in line[-9] or '0/0' in line[-9]) and ('.' in line[-8] or '0/0' in line[-8]) and  ('1/1' in line[-11]) and  ('.' in line[-12] or '0/0' in line[-12]) and  ('.' in line[-13] or '0/0' in line[-13]):
		AWD_single.append(float(1))

	# If only one allele add 0.5
	if ('.' in line[-1] or '0/0' in line[-1]) and ('.' in line[-2] or '0/0' in line[-2]) and ('.' in line[-3] or '0/0' in line[-3]) and ('.' in line[-4] or '0/0' in line[-4]) and  ('.' in line[-5] or '0/0' in line[-5]) and  ('.' in line[-6] or '0/0' in line[-6]) and ('.' in line[-7] or '0/0' in line[-7]) and  ('.' in line[-10] or '0/0' in line[-10]) and ('.' in line[-9] or '0/0' in line[-9]) and ('.' in line[-8] or '0/0' in line[-8]) and  ('0/1' in line[-11]) and  ( '.' in line[-12]  or '0/0' in line[-12]) and  ('.' in line[-13] or '0/0' in line[-13]):
		AWD_single.append(float(0.5))


if (numpy.sum(AWD_single) > 0) and (numpy.sum(SegregationSites) > 0):
	AWD=numpy.sum(AWD_single)
	Diver=0
	Diver=float((numpy.sum(AWD_single)/sites_passing))
	Segre=float((numpy.sum(SegregationSites)/11)/sites_passing)
	SinglBySeg = Diver/Segre
	print('%s\t%d\t%d\t%f\t%f\t%f\t%f\t%d\t%d\t%s' % (chromo,start_pos,end_pos,AWD,Diver,Segre,SinglBySeg,sites_present,sites_passing,EnsemblID))
    
elif (numpy.sum(AWD_single) == 0) and (numpy.sum(SegregationSites) > 0):
	AWD=AWD=numpy.sum(AWD_single)
	Diver=0
	Segre=float((numpy.sum(SegregationSites)/11)/sites_passing)
	print('%s\t%d\t%d\t%f\t%f\t%f\t%s\t%d\t%d\t%s' % (chromo,start_pos,end_pos,AWD,Diver,Segre,"Only_Segre",sites_present,sites_passing,EnsemblID))

# Add zero if Segragation is equal to zero
if (numpy.sum(AWD_single) > 0) and (numpy.sum(SegregationSites) == 0):
	AWD=numpy.sum(AWD_single)
	Diver=0
	Diver=float((numpy.sum(AWD_single)/sites_passing))
	Segre=0
	print('%s\t%d\t%d\t%f\t%f\t%f\t%s\t%d\t%d\t%s' % (chromo,start_pos,end_pos,AWD,Diver,Segre,"Only_SingleBBJ",sites_present,sites_passing,EnsemblID))

elif (numpy.sum(AWD_single) == 0) and (numpy.sum(SegregationSites) == 0):
	AWD=numpy.sum(AWD_single)
	Diver=0
	Segre=0
	print('%s\t%d\t%d\t%f\t%f\t%f\t%s\t%d\t%d\t%s' % (chromo,start_pos,end_pos,AWD,Diver,Segre,"No_variant",sites_present,sites_passing,EnsemblID))

VCF.close()
exit()
