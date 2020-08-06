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
chromo_size={'chr01':122678785,'chr02':85426708,'chr03':91889043,'chr04':88276631,'chr05':88915250,'chr06':77573801,'chr07':80974532,'chr08':74330416,'chr09':61074082,'chr10':69331447,'chr11':74389097,'chr12':72498081,'chr13':63241923,'chr14':60966679,'chr15':64190966,'chr16':59632846,'chr17':64289059,'chr18':55844845,'chr19':53741614,'chr20':58134056,'chr21':50858623,'chr22':61439934,'chr23':52294480,'chr24':47698779,'chr25':51628933,'chr26':38964690,'chr27':45876710,'chr28':41182112,'chr29':41845238,'chr30':40214260,'chr31':39895921,'chr32':38810281,'chr33':31377067,'chr34':42124431,'chr35':26524999,'chr36':30810995,'chr37':30902991,'chr38':23914537,'chrX':123869142}

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
		
		sites_poly=0
		sites_WithInfo=0
		for i in range(0,len(samples)):
			GT=line[i+9]
			if GT!='.': sites_WithInfo+=1
			if GT!='.' and GT.split(':')[0]!='0/0': sites_poly+=1
			if GT!='.' and GT.split(':')[0]!='0/0': calls[i]+=1
			#if '.' in GT: print(GT)
			#if '.' not in GT.split(':')[0] and '0/0' not in GT.split(':')[0]: print(GT)
			if '.' not in GT.split(':')[0] and '0/0' not in GT.split(':')[0]: calls[i]+=1			
			#if GT.split(':')[0]=='0/1': hets[i]+=1
			#if calls>8: outVCF.write('%s\t%s\t%s\n' % ('\t'.join(line[0:6]), 'FAIL_missing', '\t'.join(line[7:])) ); continue
			
		if sites_poly>0:
			# print(line)
			ALL.append(int(1))
		else:
			ALL.append(int(0))


		if sites_WithInfo>8:
                        # print(line)
                        Info_sites.append(int(1))
                else:
                     	Info_sites.append(int(0))	
	#sum sites with more than 12 species with polymorphic
	Poly=numpy.sum(ALL)
	Info_sites=numpy.sum(Info_sites)
 	print('%s\t%s\t%s\t%s\t%s\t%s\t%s' % (chromo,window_start,sites_present,sites_visited,'\t'.join(map(str,calls)),str(Poly),str(Info_sites)))
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

