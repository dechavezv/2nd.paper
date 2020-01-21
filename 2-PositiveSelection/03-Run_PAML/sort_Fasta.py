#!/usr/bin/env python

import sys

InfileName= sys.argv[1]
OutFileName= sys.argv[2]

OutFile = open(OutFileName, 'w')

from Bio import SeqIO
handle = open(InfileName, "rU")
l = SeqIO.parse(handle, "fasta")
sortedList = [f for f in sorted(l, key=lambda x : x.id)]
for s in sortedList:
  OutFile.write('>' + s.description + '\n')
  OutFile.write(str(s.seq) + '\n') 
 
