import os
for i in range(100):
	folder=str(i+1)
	os.chdir(folder)
	os.system("qsub -pe orte 1 run.qsub") 
	os.chdir("..")
