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
BD_single = []
MW_single = []
SegregationSites = []
Missing=[]

sites_present,sites_passing=0,0
for line in parsevcf.fetch(chromo,start_pos,end_pos):
	line = line.split('\t')
	sites_present+=1
	# Get Singletones bush dog
	if ('FAIL' in line[6]): continue
	sites_passing+=1
	
	#Account for missingness
	missing=0
        for i in range(0,len(samples)):
                if GTfilter(samples[i], line[i+9])=='.': missing+=1
        Missing.append(float(missing/23))
	
	#Caluclate Segregation Sites
	for i in range(9,32):
		if i == 19: continue #if you want to exclude Gray fox
		if i == 27 or i==28 or i==28 or i==30: continue #if you want to exclude BD
		if i==12 or i==13 or i==14 or i==15 or i==16 : continue #if you want to exclude MW
		else:
			field=line[i].split(':')  			
			if ('1/1' in field[0]):
				SegregationSites.append(float(1))
			elif ('0/1' in field[0]):
				SegregationSites.append(float(0.5))
	
	#Calculate Singletones
	#All sites homozygous reference but BD 
	if  ('1/1' in line[27] or '0/1' in line[27]) and ('1/1' in line[28] or '0/1' in line[28]) and ('1/1' in line[29] or '0/1' in line[29]) and ('1/1' in line[30] or '0/1' in line[30]) and ('1/1' not in line[12]) and ('0/1' not in line[12]) and ('1/1' not in line[13]) and ('0/1' not in line[13]) and ('1/1' not in line[14]) and ('0/1' not in line[14]) and ('1/1' not in line[15]) and ('0/1' not in line[15]) and ('1/1' not in line[16]) and ('0/1' not in line[16]) and ('1/1' not in line[9]) and ('0/1' not in line[9]) and  ('1/1' not in line[10]) and ('0/1' not in line[10]) and ('1/1' not in line[11]) and ('0/1' not in line[11]) and  ('1/1' not in line[17]) and ('0/1' not in line[17]) and ('1/1' not in line[18]) and ('0/1' not in line[18]) and ('1/1' not in line[19]) and ('0/1' not in line[19]) and ('1/1' not in line[20]) and ('0/1' not in line[20]) and  ('1/1' not in line[21]) and ('0/1' not in line[21]) and ('1/1' not in line[22]) and ('0/1' not in line[22]) and  ('1/1' not in line[23]) and ('0/1' not in line[23]) and ('1/1' not in line[24]) and ('0/1' not in line[24]) and  ('1/1' not in line[25]) and ('0/1' not in line[25]) and ('1/1' not in line[26]) and ('0/1' not in line[26]) and  ('1/1' not in line[26]) and ('0/1' not in line[26]):
		print(line)
		for i in range(27,31):
			field=line[i].split(':')
			if ('1/1' in field[0]):
				BD_single.append(float(1))
			elif ('0/1' in field[0]):
				BD_single.append(float(0.5))

	#All sites homozygous reference	but MW
	if  ('1/1' not in line[27]) and ('0/1' not in line[27]) and ('1/1' not in line[28]) and ('0/1' not in line[28]) and ('1/1' not in line[29]) and ('0/1' not in line[29]) and ('1/1' not in line[30]) and ('0/1' not in line[30]) and ('1/1' in line[12] or '0/1' in line[12]) and ('1/1' in line[13] or '0/1' in line[13]) and ('1/1' in line[14] or '0/1' in line[14]) and ('1/1' in line[15] or '0/1' in line[15]) and ('1/1' in line[16] or '0/1' in line[16]) and ('1/1' not in line[9]) and ('0/1' not in line[9]) and  ('1/1' not in line[10]) and ('0/1' not in line[10]) and ('1/1' not in line[11]) and ('0/1' not in line[11]) and  ('1/1' not in line[17]) and ('0/1' not in line[17]) and ('1/1' not in line[18]) and ('0/1' not in line[18]) and ('1/1' not in line[19]) and ('0/1' not in line[19]) and ('1/1' not in line[20]) and ('0/1' not in line[20]) and  ('1/1' not in line[21]) and ('0/1' not in line[21]) and ('1/1' not in line[22]) and ('0/1' not in line[22]) and  ('1/1' not in line[23]) and ('0/1' not in line[23]) and ('1/1' not in line[24]) and ('0/1' not in line[24]) and  ('1/1' not in line[25]) and ('0/1' not in line[25]) and ('1/1' not in line[26]) and ('0/1' not in line[26]) and  ('1/1' not in line[26]) and ('0/1' not in line[26]):
		for i in range(12,17):
			field=line[i].split(':')
			if ('1/1' in field[0]):
				MW_single.append(float(1))
			elif ('0/1' in field[0]):
				 MW_single.append(float(0.5))


if (numpy.sum(MW_single) > 0) or (numpy.sum(BD_single) > 0) and (numpy.sum(SegregationSites) > 0):
	TotalBD=float(((numpy.sum(BD_single)/4)/sites_passing))
	TotalMW=float(((numpy.sum(MW_single)/5)/sites_passing))
	Diver=float(TotalBD-TotalMW)
	Segre=float((numpy.sum(SegregationSites)/13)/sites_passing)
	SinglBySeg = Diver/Segre
	Missingness=Missing/sites_passing
	print('%s\t%d\t%d\t%f\t%f\t%f\t%d\t%d\t%d\t%d\t%d\t%s' % (chromo,start_pos,end_pos,TotalBD,TotalMW,Diver,Segre,SinglBySeg,sites_present,sites_passing,Missingness,EnsemblID))


elif (numpy.sum(MW_single) == 0) and (numpy.sum(BD_single) == 0) and (numpy.sum(SegregationSites) > 0):
	Diver=0
	Segre=float((numpy.sum(SegregationSites)/13)/sites_passing)
	Missingness=Missing/sites_passing
	print('%s\t%d\t%d\t%f\t%f\t%s\t%d\t%d\t%d\t%s' % (chromo,start_pos,end_pos,Diver,Segre,"Only_Segre",sites_present,sites_passing,Missingness,EnsemblID))



# Add zero if Segragation is equal to zero
elif (numpy.sum(BD_single) == 0) and (numpy.sum(MW_single) > 0) and (numpy.sum(SegregationSites) == 0):
	Diver=0
	TotalMW=float(((numpy.sum(MW_single)/5)/sites_passing))
	Diver=0-TotalMW
	Segre=0
	Missingness=Missing/sites_passing
	print('%s\t%d\t%d\t%f\t%f\t%s\t%d\t%d\t%d\t%s' % (chromo,start_pos,end_pos,Diver,Segre,"Only_SingleMW",sites_present,sites_passing,Missingness,EnsemblID))

elif (numpy.sum(MW_single) > 0) and (numpy.sum(BD_single) > 0) and (numpy.sum(SegregationSites) == 0):
	Diver=0
	TotalBD=float(((numpy.sum(BD_single)/4)/sites_passing))
	TotalMW=float(((numpy.sum(MW_single)/5)/sites_passing))
	Diver=float(TotalBD-TotalMW)
	Segre=0
	Missingness=Missing/sites_passing
	print('%s\t%d\t%d\t%f\t%f\t%s\t%d\t%d\t%d\t%s' % (chromo,start_pos,end_pos,Diver,Segre,"Only_SingleBD_MW",sites_present,sites_passing,Missingness,EnsemblID))

elif (numpy.sum(MW_single) == 0) and (numpy.sum(BD_single) > 0) and (numpy.sum(SegregationSites) == 0):
	Diver=0
	TotalBD=float(((numpy.sum(BD_single)/4)/sites_passing))
	Segre=0
	Diver=TotalBD-0
	Missingness=Missing/sites_passing
	print('%s\t%d\t%d\t%f\t%f\t%s\t%d\t%d\t%d\t%s' % (chromo,start_pos,end_pos,Diver,Segre,"Only_SingleBD",sites_present,sites_passing,Missingness,EnsemblID))

elif (numpy.sum(MW_single) == 0) and (numpy.sum(BD_single) == 0) and (numpy.sum(SegregationSites) == 0):
	Diver=0
	Segre=0
	Missingness=Missing/sites_passing
	print('%s\t%d\t%d\t%f\t%f\t%s\t%d\t%d\t%d\t%s' % (chromo,start_pos,end_pos,Diver,Segre,"No_variant",sites_present,sites_passing,Missingness,EnsemblID))

VCF.close()
exit()
