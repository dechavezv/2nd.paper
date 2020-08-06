import sys

outfile=open(sys.argv[1] + "Partirion_1.txt", "w+")
outfile2=open(sys.argv[1] + "Partirion_2.txt", "w+")
outfile3=open(sys.argv[1] + "Partirion_3.txt", "w+")

infile= open(sys.argv[1],'r')

for line in infile:
	if line.startswith('>'):
		outfile.write(line)
		outfile2.write(line)
		outfile3.write(line)
	else:
		line = line.strip()
		#print(line[0::3])  
		outfile.write(line[0::3] + '\n')
		outfile2.write(line[1::3] + '\n')
		outfile3.write(line[2::3] + '\n')
outfile.close()

