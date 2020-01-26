
'''
Author: Daniel Chavez, April 2017 @
This script will masked all lowercase latters with N; lower case latters are indicators of very low or hihg  depth
and were obtianed with seqtk tool
usage:

python lowercase_to_N.py <infile.fasta>
'''

import sys
import re

infile = open(sys.argv[1], 'r')
outfile = open("Masked_depth_" + sys.argv[1], 'w')

for line in infile:
	if line.startswith('>'):
		outfile.write(line)
	else:
		lines = re.sub('a|t|g|c|r|y|s|w|k|m|b|d|h|v|n', 'N', line.strip()) 
		outfile.write(lines + "\n")

outfile.close()
