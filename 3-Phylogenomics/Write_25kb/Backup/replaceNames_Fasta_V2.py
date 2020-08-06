#!/usr/bin/env python
import sys

bed = open(sys.argv[2],'r')
Orto_genes = open(sys.argv[1],'r')
outfile = open(sys.argv[3] + sys.argv[1], 'w') 

d = {}

for line in bed:
	line = line.strip()
	line2 = line.split('\t')
    	try:
        	d['>'+ line2[3] + '-' + line2[0] + '-' + line2[1] + '-' + line2[2]] = line
        except:
        	pass
        	
for line3 in Orto_genes:
		line3 = line3.strip()
                if line3.startswith('>'):
                        j = line3.replace(line3,d[line3])
                        outfile.write('>' + j + '\n')
		else:
			outfile.write(line3 + '\n')
outfile.close()
