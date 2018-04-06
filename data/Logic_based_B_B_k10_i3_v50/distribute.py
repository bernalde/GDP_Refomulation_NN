import os
qsub ="#!/bin/bash\n#\n#$ -cwd\n#$ -S /bin/bash\n"
cwd = os.getcwd()
for i in range(100):
	folder = str(i+1)
	new_line = "set iter /" + folder + "*" + folder + "/"
	os.system("cp -r 0 " +  folder)
	os.system("{ echo '" + new_line +"'; cat run_batch0.gms; } >" + folder + "/run_batch.gms")
	file = open(folder+"/run.qsub", "w")
	file.write(qsub)
	file.write("cd " + cwd + "/" + folder)
	file.write("\ngams run_batch.gms")
	file.close()

