'''
Author: Daniel Chavez (July_24_2017)

usage:
python Genes_within_25kb_Windows_Phylogeny.py <25_kb_bed_File.bed> <Orto_genes.bed>
'''

import sys

file1 = open(sys.argv[1], 'r')
file2 = sys.argv[2]
outfile = open('Orto_genes_' + sys.argv[1], 'w')

list2 = [line.strip() for line in open(file2,'r')] #read files as list

for line in file1:
	line = line.split('\t')
	chr = str(line[0]) 
	start = float(line[1])
	end = float(line[2])
	for i in range(len(list2)):
		line2 = list2[i].split('\t')
		if chr == line2[0] and float(line2[1]) < float(end) and float(line2[2]) > float(start):
			print(line2[3])					
			outfile.write(line2[3] + '\n')
outfile.close()
