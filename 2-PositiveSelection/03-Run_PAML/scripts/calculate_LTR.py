#!/usr/bin/env python
import sys
from Bio.Phylo.PAML.chi2 import cdf_chi2

infile = sys.argv[1]
outfile = sys.argv[2]

fasta= open(infile, 'r')
newfasta= open(outfile, 'w')

for Line in fasta:
	Line = Line.strip('\n')
        ElementList = Line.split('\t')
        x = (float(ElementList[1]) - float(ElementList[2]))
        values = 2*(abs(x))
        newfasta.write(ElementList[0] + '\t' + str(values) + '\n')
fasta.close()
newfasta.close()

