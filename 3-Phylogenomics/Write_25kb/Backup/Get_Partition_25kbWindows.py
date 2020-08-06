'''
Author: Daniel Chavez (July_24_2017)

usage:
python Genes_within_kb_Windows_Phylogeny.py <25_kb_bed_File.bed> <Orto_genes.bed>
'''

import sys

file1 = open(sys.argv[1], 'r')
file2 = sys.argv[2]
outfile = open('Orto_genes_' + sys.argv[1], 'w')

list2 = [line.strip() for line in open(file2,'r')] #read files as list

for line in file1:
	line = line.split('\t')
	kb_chr = str(line[0])
	kb_start = int(line[1])
	kb_end = int(line[2])
	d = kb_chr + '_' + str(kb_start) + '_' + str(kb_end)
   	outfile = open(d + ".bed",'w')
	for i in range(len(list2)):
		line2 = list2[i].split('\t')
		Gene_chr = line2[0]
		Gene_start = int(line2[1])
		Gene_end = int(line2[2])
		Trans_name = line2[4]
		
		if kb_chr == Gene_chr and Gene_end < kb_end and Gene_end > kb_start and Gene_start > kb_start:
			End_Trans = Gene_end - kb_start
			Start_Trans = Gene_start - kb_start
			outfile.write(kb_chr + '\t' + str(Start_Trans) + '\t' + str(End_Trans) + '\t' + str(Trans_name) + '\n')
		
		elif kb_chr == Gene_chr and Gene_end < kb_end and Gene_end > kb_start and Gene_start < kb_start:
			End_Trans = Gene_end - kb_start
			Start_Trans = int(1)
			outfile.write(kb_chr + '\t' + str(Start_Trans) + '\t' + str(End_Trans) + '\t' + str(Trans_name) + '\n')
		
		elif kb_chr == Gene_chr and Gene_end > kb_end and Gene_start < kb_start:
			End_Trans =  int(25000)
			Start_Trans = Gene_start - kb_start
			outfile.write(kb_chr + '\t' + str(Start_Trans) + '\t' + str(End_Trans) + '\t' + str(Trans_name) + '\n')
	
		elif kb_chr == Gene_chr and Gene_end == kb_end and Gene_start > kb_start:
			End_Trans = int(25000)
			Start_Trans = Gene_start - kb_start
			outfile.write(kb_chr + '\t' + str(Start_Trans) + '\t' + str(End_Trans) + '\t' + str(Trans_name) + '\n')
		
		elif kb_chr == Gene_chr and Gene_end < kb_end and Gene_start == kb_start:
			End_Trans = Gene_end - kb_start
			Start_Trans = int(1)
			outfile.write(kb_chr + '\t' + str(Start_Trans) + '\t' + str(End_Trans)  + '\t' + str(Trans_name) + '\n')
			
outfile.close()
