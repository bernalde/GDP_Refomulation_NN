import os 
selected_features = [1,2, 3]
cols = ""
for col in selected_features:
	cols = cols + "$" + str(col+1)
os.system("awk '{print $1," + cols + "}'")