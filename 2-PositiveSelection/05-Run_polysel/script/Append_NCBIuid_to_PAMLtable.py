#!/usr/bin/env python
import sys


Orto_genes = open(sys.argv[1],'r')
BEB_sites = open(sys.argv[2],'r')
outfile = open(sys.argv[3] + sys.argv[1], 'w') 

d = {}

for line in BEB_sites:
	line2 = line.split('\t')
   	try:
		#print(line2[2])
		d[line2[0]] = line
        except:
        	pass
        	
for line3 in Orto_genes:
		line3 = line3.strip()
		line4 = line3.split('\t')
		name = line4[1]

                if line3.startswith('objID'):
			outfile.write('SUMSTAT' + '\t' + line3 + '\n')
			#outfile.write('objID' + '\t' + line3 + '\n')
		else:
			try:   
				A = d[name]
				A = A.split('\t')
				BEB = A[1]
				BEB =  BEB.strip()
				#number_sites = float(BEB.count(',')) + 1					                
                        	outfile.write(BEB + '\t' + line3  + '\n')
			except KeyError:
         			outfile.write('NA' + '\t' + line3 + '\n')
outfile.close()
