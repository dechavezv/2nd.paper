'''

Specify region:
python /work2/dechavezv/scripts/SlidingWindowHet_v3.py chr12.vcf.gz 100000 10000 chr12 792227 2707784 

Do whole chromosome: 
python /work2/dechavezv/scripts/SlidingWindowHet_v3.py chr12.vcf.gz 100000 10000 chr12

'''

import sys
import pysam
import os
import gzip
import numpy

filename = sys.argv[1]
VCF = gzip.open(filename, 'r')

if not os.path.exists("%s.tbi" % filename):
	pysam.tabix_index(filename, preset="vcf")
parsevcf = pysam.Tabixfile(filename)

window_size = int(sys.argv[2])
step_size = int(sys.argv[3])
chromo = sys.argv[4]
chromo_size={'PseudoChr_1':184543835,'PseudoChr_10':18854620,'PseudoChr_11':19233170,'PseudoChr_12':19908907,'PseudoChr_13':20449329,'PseudoChr_14':16032832,'PseudoChr_15':15253639,'PseudoChr_16':15082875,'PseudoChr_17':13971486,'PseudoChr_18':10912856,'PseudoChr_19':10310148,'PseudoChr_2':138169185,{'PseudoChr_20':9858351,'PseudoChr_21':7121271,'PseudoChr_22':6876133,'PseudoChr_23':5063586,'PseudoChr_24':5717744,'PseudoChr_25':6992922,'PseudoChr_26':4801153,'PseudoChr_27':4812762,'PseudoChr_28':2365507,'PseudoChr_29':2165917,'PseudoChr_3':94387236,'PseudoChr_30':872971,'PseudoChr_31':1052411,'PseudoChr_32':758239,'PseudoChr_33':454491,'PseudoChr_34':443711,'PseudoChr_35':426649,'PseudoChr_4':59784752,'PseudoChr_5':52304319,'PseudoChr_6':34310480,'PseudoChr_7':29457210,'PseudoChr_8':24927619,'PseudoChr_9':20179708,'PseudoChr_W':2247491}

samples=[]
for line in VCF:
	if line.startswith('##'):
		pass
	else:
		for i in line.split()[9:]: samples.append(i)
		break

# If a region is supplied, use those coordinates for start and end positions
# If no region is specified, start position is the first position in the VCF file, and end position is the length of the chromosome

if len(sys.argv)>5:
	start_pos = int(sys.argv[5])
	end_pos = int(sys.argv[6])
#	output = open(filename + '_het_%swindow_%sstep_%s_%s_%s_region.txt' % (window_size, step_size, chromo, start_pos, end_pos), 'w')
else:
	for line in VCF:
		if line[0] != '#':
			start_pos = int(line.strip().split()[1])
			end_pos = chromo_size[chromo]
			break
#	output = open(filename + '_het_%swindow_%sstep_%s.txt' % (window_size, step_size, chromo), 'w')

print('chromo\twindow_start\tsites_present\tsites_visited\tcalls_%s\tPoly\tsites9sp' % ('\tcalls_'.join(samples)))#, '\thets_'.join(samples)) )

# Fetch a region, apply filters, tally calls and heterozygotes		
def snp_cal(chromo,window_start,window_end):
#
	rows = tuple(parsevcf.fetch(region="%s:%s-%s" % (chromo, window_start, window_end), parser=pysam.asTuple()))
#	
	sites_present,sites_visited=0,0
	calls=[0]*len(samples)
	hets=[0]*len(samples)
	ALL=[]
	Info_sites=[]
#
	for line in rows:
		sites_present+=1
		if 'FAIL' in line[6]: continue
		sites_visited+=1
		if line[4]=='.': continue
		#if line[4]!='.': print(line)
		
		sites_WithInfo=0
		for i in range(0,len(samples)):
			GT=line[i+9]
			if GT!='.': sites_WithInfo+=1
			
		if sites_WithInfo>4:
                        # print(line)
                        Info_sites.append(int(1))
                else:
                     	Info_sites.append(int(0))	
	#sum sites with more than 12 species with polymorphic
	Poly=numpy.sum(ALL)
	Info_sites=numpy.sum(Info_sites)
 	print('%s\t%s\t%s\t%s\t%s\t%s\t%s' % (chromo,window_start,sites_present,sites_visited,str(Info_sites)))
	#print('%s\t%s\t%s\t%s\t%s\t%s' % (chromo,window_start,sites_present,sites_visited,'\t'.join(map(str,calls)),'\t'.join(map(str,hets))))
	


# initialize window start and end coordinates
window_start = start_pos
window_end = start_pos+window_size-1

# calculate stats for window, change window start and end positions
while window_end <= end_pos:

    if window_end < end_pos:
        snp_cal(chromo,window_start,window_end)
        window_start = window_start + step_size + window_size
        window_end = window_start + window_size - 1

    else:
	snp_cal(chromo,window_start,window_end)
        break

else:
    window_end = end_pos
    snp_cal(chromo,window_start,window_end)

VCF.close()
exit()



# initialize window start and end coordinates
#window_start = start_pos
#window_end = start_pos+window_size-1

# calculate stats for window, change window start and end positions
#while window_end <= end_pos:	
			
#	if window_end < end_pos:
#		snp_cal(chromo,window_start,window_end)

#		window_start = window_start + step_size + window_size
#		window_end = window_start + window_size - 1

#	else:
#		snp_cal(chromo,window_start,window_end)
#		break	
		
#else:
#	window_end = end_pos
#	snp_cal(chromo,window_start,window_end)


#VCF.close()

#exit()

