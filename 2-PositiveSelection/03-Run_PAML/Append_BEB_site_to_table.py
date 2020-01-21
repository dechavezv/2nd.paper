#!/usr/bin/env python
import sys

Orto_genes = open(sys.argv[1],'r')
BEB_sites = open(sys.argv[2],'r')
outfile = open(sys.argv[3] + sys.argv[1], 'w') 

d = {}

for line in BEB_sites:
	line2 = line.split('\t')
    	try:
		d[line2[0]] = line
        except:
        	pass
        	
for line3 in Orto_genes:
		line3 = line3.strip()
		line4 = line3.split('\t')
		name = line4[0]
                if line3.startswith('ENSEMBL'):
			outfile.write(line3 + '\t' + 'BEB_site' + '\n')
		else:
			try:   
				A = d[name]
				A = A.split('\t')
				BEB = A[1]
				BEB =  BEB.strip()
				number_sites = float(BEB.count(',')) + 1					                
                        	outfile.write(line3 + '\t' + BEB + '\t' + str(number_sites) + '\n')
			except KeyError:
         			outfile.write(line3 + '\n')
outfile.close()
