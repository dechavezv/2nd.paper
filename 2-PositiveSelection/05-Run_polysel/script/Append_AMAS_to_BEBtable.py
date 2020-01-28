#!/usr/bin/env python
import sys

BEB_Table = open(sys.argv[1],'r')
AMAS_sites = open(sys.argv[2],'r')
outfile = open(sys.argv[3] + sys.argv[1], 'w') 

Usage = """

python ../Append_AMAS_to_BEBtable.py BEB_Table.txt AMAS_Sites AMAS_

"""

if len(sys.argv) < 2:
	print(Usage)
else:

	d = {}

	for line in AMAS_sites:
		line2 = line.split('\t')
    		try:
			d[line2[0]] = line
        	except:
        		pass
        	
	for line3 in BEB_Table:
		line3 = line3.strip()
		line4 = line3.split('\t')
		name = line4[0]
		if line3.startswith('Ensmebl'):
			outfile.write(line3 + '\t' + 'Alignment_name' + '\t' + 'No_of_taxa' + '\t' + 'Alignment_length' + '\t' + 'Total_matrix_cells' + '\t' + 'Undetermined_characters' + '\t' + 'Missing_percent' + '\t' + 'No_variable_sites' + '\t' + 'Proportion_variable_sites' + '\t' + 'Parsimony_informative_sites' + '\t' + 'Proportion_parsimony_informative' + '\t' + 'AT_content' + '\t' + 'GC_content' + '\t' + 'A' + '\t' + 'C' + '\t' + 'G' + '\t' + 'T' + '\t' + 'K' + '\t' + 'M' + '\t' + 'R' + '\t' + 'Y' + '\t' + 'S' + '\t' + '?' + '\n')
		else:
			try:   
				A = d[name]
				#A = A.split('\t')
				#BEB = A[1]
				#BEB =  BEB.strip()
				#number_sites = float(BEB.count(',')) + 1					                
                        	outfile.write(line3 + '\t' + A + '\n')
			except KeyError:
         			outfile.write(line3 + '\n')
	outfile.close()
