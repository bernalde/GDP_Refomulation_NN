import sqlite3
import pandas as pd
from GDP_instance import GDP
import os 

#initialize feature output file
os.system(' echo "" > features_for_libsvm')
os.system(' echo "" > map_features_for_libsvm')

# '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_jobshop_78/Euler',\
# '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_jobshop_79/Euler',\


# '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_k10_i3_v50/Euler',\
# '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_k10_i3_v80/Euler',\
# '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_k5_i30_v30/Euler',\
# '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_k7_i15_v50/Euler',\
# '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_k8_i5_v40/Euler',\
# '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_k8_i5_v50/Euler',\
# '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_strip_4/Euler',\
# '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_strip_42/Euler',\
# '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_strip_5/Euler',\
# '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_strip_52/Euler'
# '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_jobshop_53/Euler',\
# '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_jobshop_54/Euler',\
# '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_jobshop_55/Euler',\
# '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_jobshop_56/Euler',\
# '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_jobshop_57/Euler',\
# '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_jobshop_58/Euler',\
# '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_jobshop_59/Euler',\
# '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_jobshop_63/Euler',\
# '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_jobshop_66/Euler',\
# '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_jobshop_67/Euler'

 # '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_food_4/Euler',\
 # '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_food_5/Euler'
data_directories = [ '/home/canl1/work/GDP_Refomulation_NN/data/Logic_based_B_B_contracts/Euler'
]

for directory in data_directories:	
	os.chdir(directory)
	for folder in range(20):
		os.chdir(str(folder))
		solution = sqlite3.connect("solution_total.db")
		stat = sqlite3.connect("stat_total.db")
		for prob in range(10):
			print folder, prob, directory
			temp_solution = pd.read_sql_query("SELECT * FROM solu", solution)
			
			for index, row in temp_solution.iterrows():
				if int(row['iter']) == prob+1: 
					prob_tab = sqlite3.connect("prob_data_" + str(prob+1 + folder*10) + ".db")
					# if folder >=2 and folder<10:
					# 	prob_tab = sqlite3.connect("prob_data_" + str(100+prob+1 + folder*10) + ".db")
					# elif folder>=10:
					# 	prob_tab = sqlite3.connect("prob_data_" + str(prob+1 + folder*10-80) + ".db")
					# else:
						
					new_GDP_instance = GDP(prob_tab=prob_tab, solution=solution, stat=stat, problem_index=prob+1)
					new_GDP_instance.get_features()
					print len(new_GDP_instance.features), new_GDP_instance.features
					print new_GDP_instance.solution
					print new_GDP_instance.stat
					if len(new_GDP_instance.features) == 16:
						new_GDP_instance.write_features_to_libsvm()
						temp = open("/home/canl1/work/GDP_Refomulation_NN/features/map_features_for_libsvm", "a")
						temp.write(directory + "/" + str(folder) + "/" + str(prob+1 + folder * 10) + "\t")
						temp.close()
						new_GDP_instance.write_features_to_libsvm1()
					# new_GDP_instance.write_features()
					prob_tab.close()
					break
			
			# break
		# break
			
		solution.close()
		stat.close()
		os.chdir("..")
		
	# break 	`
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

