#!/usr/bin/env python
import sys
from Bio.Phylo.PAML.chi2 import cdf_chi2

infile = sys.argv[1]
outfile = sys.argv[2]

fasta= open(infile, 'r')
newfasta= open(outfile, 'w')

for Line in fasta:
	if Line.startswith('objID'): pass
        else:
		Line = Line.strip('\n')
        	ElementList = Line.split('\t')	
		x = float(ElementList[5])
       	 	#x = (2*(float(ElementList[1]) - float(ElementList[2])))     

		if x < 0:
       			#values = 2*(abs(x))
        		newfasta.write(ElementList[1] + '\t' + str(0) + '\n')
        	else:
             		x = x**(float(1)/float(4))
                	newfasta.write(ElementList[1] + '\t' + str(x) + '\n')
fasta.close()
newfasta.close()
