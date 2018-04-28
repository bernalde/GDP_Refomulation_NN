a = "/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_k5_i30_v30/Euler/0/1	1 1:30 2:9.6 3:48 4:5 5:0.837668213471 6:23.6875 7:8.0 8:315.0 9:112.0 10:59177.648417 11:8.0 12:83.0 13:24.0 14:-49.5851053065 15:7.13 16:0.00281751667378\n"
def get_y(line):
	return line.strip().split(" ")[0]
def get_sparsity(line):
	sparsity = line.strip().split(" ")[5].split(":")[1]
	return sparsity

def get_gap(line):
	HR_rel = float(line.strip().split(" ")[10].split(":")[1])
	BM_rel = float(line.strip().split(" ")[14].split(":")[1])
	return str((HR_rel - BM_rel) / abs((HR_rel+BM_rel)/2))

def get_ratio_vars(line):
	HR_vars = float(line.strip().split(" ")[9].split(":")[1])
	BM_vars = float(line.strip().split(" ")[13].split(":")[1])
	return str(HR_vars / BM_vars)

def get_ratio_const(line):
	HR_const = float(line.strip().split(" ")[8].split(":")[1])
	BM_const = float(line.strip().split(" ")[12].split(":")[1])	
	return str(HR_const/BM_const)

temp = open("map_features_for_libsvm", "r").readlines()
f = open("function_of_features", "w")
for line in temp:
	f.write(get_y(line))
	f.write(" 1:" + get_sparsity(line) + " 2:" + get_gap(line) + " 3:" + get_ratio_vars(line) + " 4:" + get_ratio_const(line) + "\n")

