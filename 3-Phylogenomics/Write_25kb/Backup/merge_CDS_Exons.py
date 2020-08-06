import sys
import re
def __main__():
    infile  = sys.argv[1]
    outfile = sys.argv[2]

    with open(infile, 'rb') as fi:
        seqs = fi.read().split('>')[1:]
        seqs = [x.split('\n')[:2] for x in seqs]

    merge = dict()

    #index 0 is header
    #index 1 is seq
    for x in seqs:
        #key = re.search('(?<=)(\w+\t\w+\t\W+\t\w+.+)(?=\t)', x[0]).group(0)
        key = re.search('(?<=)(\w+\t\w+\t\W)(?=\t)', x[0]).group(0)
        try:
            merge[key] = merge[key] + x[1]
            #print(merge[key])
        except KeyError:
            merge[key] = x[1]
        key = x[0]          
    #print(merge[key])        
    #print merge.keys()	
    #write results to file
    with open(outfile, 'w') as fi:
        for x in merge.keys():
            #print x
            #print merge[x]
            fi.write('>' + x + '\n')
            fi.write(merge[x] + '\n')

__main__()
