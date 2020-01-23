import os

List=[]

for file in os.listdir(os.getcwd()):
	with open(file, 'r') as f:
		first_line = f.readline()
		if not first_line.startswith('13'):
			List.append(f.name)
		else:
			pass    
#print(List)

for file in List:
	if file == 'remove_incomplete_Sequences_v2.py': 
		pass
	else: 
		#print(file)
	os.remove(file)
