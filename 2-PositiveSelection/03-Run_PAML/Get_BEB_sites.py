import sys
import re

infile = open(sys.argv[1], 'r')
#outfile = open("EEB_SITES" + sys.argv[1], 'w')

always_print = False
lines = infile.readlines()
for line in lines:
        if always_print or "Bayes Empirical Bayes (BEB)" in line:
                print line
                #outfile.write(line)
                always_print = True
        if line.startswith('The grid'):break

infile.close()
#outfile.close()


