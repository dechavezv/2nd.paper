'''
Author: Daniel Chavez (July_24_2017)

usage:
python Genes_within_HKA.py <HKA.txt> <Orto_genes.bed>
'''

import sys

file1 = open(sys.argv[1], 'r')
file2 = sys.argv[2]
outfile = open('Genes_HKA_' + sys.argv[1], 'w')

list2 = [line.strip() for line in open(file2,'r')] #read files as list

for line in file1:
	line=line.strip()
	line = line.split('\t')
	chr = str(line[0]) 
	start = float(line[1])
	end = float(line[2])
	for i in range(len(list2)):
		line2 = list2[i].split('\t')
		if chr == line2[0] and float(line2[1]) < float(end) and float(line2[2]) > float(start):
			#print('%s\t%s' % (line,line2[3]))					
			outfile.write(line[0] + '\t' + line[1] + '\t' + line[2] + '\t' + line[3] + '\t' + line[4] + '\t' + line[5] + '\t' + line[6] + '\t' + line[7] + '\t' + line[8] + '\t' + line[9] + '\t' + line2[3] + '\t' + line2[7] + '\n')
		#else:
		#	#print('%s\t%s' % (line,'NA'))
		#	outfile.write(line[0] + '\t' + line[1] + '\t' + line[2] + '\t' + line[3] + '\t' + line[4] + '\t' + line[5] + '\t' + line[6] + '\t' + line[7] + '\t' + 'NA' + '\n')
outfile.close()
