#!/usr/bin/env python
import sys

infile = sys.argv[1]
bed = sys.argv[2]
outfile = sys.argv[3] + sys.argv[1]

fasta= open(infile,'r')
newnames= open(bed,'r')
newfasta= open(outfile, 'w')

for line in fasta:
    if line.startswith('>'):
        newname= newnames.readline()
        newfasta.write('>' + newname)
    else:
        newfasta.write(line)

fasta.close()
newnames.close()
newfasta.close()

