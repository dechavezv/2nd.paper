#!/usr/bin/env python

'''
This script will filter out lines that are not contain in a reference list (sys.argv[2])
File you want to filter can have as many colums as you want. However the first colum must have names that match the first colum of the reference (sys.argv[2]) file
The reference (sys.argv[2]) file must have only one colum, if not change the script acordingly
Also names of the reference (sys.argv[2]) file must be in the file you want to filter (sys.argv[1])

usage:
python Compare_twoLists_V2.py <file_to_filter> <Reference_of_names_to_keep> <name_of_output>
'''

import sys
#files to be called with the script
infile1 = sys.argv[1] #List that you want to filter

#open file
infile = open(infile1, 'r')

infile2 = sys.argv[2] #Reference with genes that you want to keep (e.g list_color_genese.txt)

outfile = sys.argv[3]
f = open(outfile, 'w') #create and empty file

list2 = [line.strip() for line in open(infile2,'r')] #read files as list

for line in infile:
        line1 = line.strip().split('\t')
        if line1[0] in list2:
                print("item Found :-)")
		#f.write("%s" % line)   
        else:
                print("item NOT Found :-(")
		f.write("%s" % line)
f.close() # close the file
