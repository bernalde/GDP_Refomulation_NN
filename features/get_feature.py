import sqlite3
import pandas as pd
from GDP_instance import GDP
import os 

#initialize feature output file
# os.system(' echo "" > features_for_libsvm')
# '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_k10_i3_v80/Euler',\
# '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_k5_i30_v30/Euler',\
# '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_k7_i15_v50/Euler',\
# '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_k8_i5_v40/Euler',\
# '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_k8_i5_v50/Euler',\

data_directories = ['/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_k10_i3_v50/Euler',\
'/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_strip_4/Euler',\
'/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_strip_5/Euler',\
'/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_contracts/Euler']

for directory in data_directories:	
	os.chdir(directory)
	for folder in range(20):
		# folder = 10
		os.chdir(str(folder))
		solution = sqlite3.connect("solution_total.db")
		stat = sqlite3.connect("stat_total.db")
		for prob in range(10):
			# prob = 2
			print folder, prob, directory
			temp_solution = pd.read_sql_query("SELECT * FROM solu", solution)
			
			for index, row in temp_solution.iterrows():
				if int(row['iter']) == prob+1: 
					prob_tab = sqlite3.connect("prob_data_" + str(prob+1 + folder*10) + ".db")
					new_GDP_instance = GDP(prob_tab=prob_tab, solution=solution, stat=stat, problem_index=prob+1)
					new_GDP_instance.get_features()
					# new_GDP_instance.write_features_to_libsvm()
					new_GDP_instance.write_features()
					prob_tab.close()
					break
			
			break
		break
			
		solution.close()
		stat.close()
		os.chdir("..")
		
	break 
# prob_tab = sqlite3.connect("prob_data_1.db")

# temp = GDP(prob_tab=prob_tab)
# for index, row in df.iterrows():
# 	print index
# 	print row['var'], row['value']
# prob_tab = ["A", "AE", "b", "bE", "c", "ub", "lb", "term", "eq_term"]
# solu_tab = ["solu"]
# stats_tab = ["stats"]
# results = cur.fetchall()
# print(results)

