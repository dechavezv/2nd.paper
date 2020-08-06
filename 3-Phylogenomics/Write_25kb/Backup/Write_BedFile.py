
'''
usage: 
python Write_BedFile.py <input> <ouput>

input = must be the summary with the 25kb windows; your input must be tab delimited and must have at least
1st columm (Chromosome), 2nd columm (window Start) and 3rd columm (window End)
output = name of your output
'''


import sys

infile = open(sys.argv[1], 'r')
outfile = open(sys.argv[2], 'w')

for line in infile:
	if line.startswith('chromo'):
		outfile.write("CHR" + '\t' + "Window_Start" + '\t' + "Window_End" + '\n')
	else:	
		line = line.strip().split('\t')
		if float(line[17]) < 700: continue
		chromosome = line[0]
		window_start = int(line[1])
		window_end = int(line[1]) + 25000
		outfile.write(str(chromosome) + '\t' + str(window_start) + '\t' + str(window_end) + '\n')

outfile.close()
