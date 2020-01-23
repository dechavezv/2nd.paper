import os

List=[]

for file in os.listdir(os.getcwd()):
	with open(file, 'r') as f:
		first_line = f.readline()
		if '-' not in first_line:
			List.append(f.name)
		else:
			pass    
#print(List)

for file in List:
	if file == 'remove_incomplete_EEB_Sites_v1.py': 
		pass
	else: 
		print(file)
	#os.remove(file)
