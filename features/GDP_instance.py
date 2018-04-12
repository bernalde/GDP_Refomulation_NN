import sqlite3
import pandas as pd
import numpy as np
import collections

class GDP:
	def __init__(self, prob_tab=None, stat=None, solution=None, problem_index=1):
		#parse data 
		# lb = pd.read_sql_query("SELECT * FROM lb", prob_tab).as_matrix()
		# self.lb = lb[:, 1]

		# ub = pd.read_sql_query("SELECT * FROM ub", prob_tab).as_matrix()
		# self.ub = ub[:,1]
		# self.num_vars = len(ub)
		# print self.num_vars
		# term = pd.read_sql_query("SELECT * FROM term", prob_tab).as_matrix()

		
		
		# generate eq_term
		eq_term = []
		self.num_disjuncts = []
		A = pd.read_sql_query("SELECT * FROM A", prob_tab)
		index_k = 0 
		index_i = 0
		last_index_k = 0
		last_index_i = 0
		last_e_number = 0
		self.num_vars = 0
		for index,row in A.iterrows():
			# print row
			if int(row['var']) > self.num_vars:
				self.num_vars = int(row['var'])
			if int(row['k']) != last_index_k:
				index_k = int(row['k'])
				if last_index_k != 0:
					eq_term.append(last_e_number)
					self.num_disjuncts.append(index_i)

				index_i = 1

			elif int(row['i']) != last_index_i:
				index_i += 1
				eq_term.append(last_e_number)
			last_index_i = int(row['i'])
			last_index_k = int(row['k'])
			last_e_number = float(row['e'])
		eq_term.append(last_e_number)
		self.num_disjuncts.append(index_i)

		self.num_disjunctions = len(self.num_disjuncts)
		
		self.total_num_disjuncts = np.sum(self.num_disjuncts)

		# print self.num_disjunctions, self.num_disjuncts,  eq_term, len(eq_term), self.total_num_disjuncts

		# print eq_term, len(eq_term)
		self.A = []
		self.b = []
		temp_djc = 0
		
		for i in range(self.num_disjunctions):
			self.A.append([])
			self.b.append([])
			for j in range(int(self.num_disjuncts[i])):
				self.A[i].append(np.matrix(np.zeros(shape=(int(eq_term[temp_djc]), self.num_vars), dtype=float)))
				self.b[i].append(np.zeros(shape=(int(eq_term[temp_djc])), dtype=float))
				temp_djc += 1
		
#data of A can be accessed via self.A[k][i][e,var], self.b[k][i][e]
		#keep track of the A matrix
		index_k = 0 
		index_i = 0
		last_index_k = 0
		last_index_i = 0
		map_k_i = {}
		for index,row in A.iterrows():
			if int(row['k']) != last_index_k:
				index_k = int(row['k'])
				index_i = 1
			elif int(row['i']) != last_index_i:
				index_i += 1
			map_k_i[str(row['k']) + "_" + str(row['i'])] = index_i
			# print index_k, index_i, row['e'], len(self.A[index_k-1]), len(self.A[index_k-1][index_i-1])
			self.A[index_k-1][index_i-1][int(row['e'])-1, int(row['var'])-1] = row['value']
			last_index_i = int(row['i'])
			last_index_k = int(row['k'])

		b = pd.read_sql_query("SELECT * FROM b", prob_tab)

		index_k = 0 
		index_i = 0
		last_index_k = 0
		last_index_i = 0
		
		for index,row in b.iterrows():
			# print row['k'], map_k_i[str(row['k']) + "_" + str(row['i'])], row['e']
			# print  len(self.b),len(self.b[int(row['k'])-1]), len(self.b[int(row['k'])-1][map_k_i[str(row['k']) + "_" + str(row['i'])]-1])
			if int(row['e']) > len(self.b[int(row['k'])-1][map_k_i[str(row['k']) + "_" + str(row['i'])]-1]):
				continue
			self.b[int(row['k'])-1][map_k_i[str(row['k']) + "_" + str(row['i'])]-1][int(row['e'])-1] = row['value']


		self.c = np.zeros(shape=(self.num_vars), dtype=float)
		c = pd.read_sql_query("SELECT * FROM c", prob_tab)
		
		for index, row in c.iterrows():
			self.c[int(row['var'])-1] = row['value']

		#parse model stat
		stat_matrix = pd.read_sql_query("SELECT * FROM stats", stat)
		#stat is 2 2d directionary. access via stat['BM']['bin']
		#{'HR': {'bin': 25.0, 'const': 2676.0, 'vars': 1064.0, 'rel': -423.05460859643443}, 'BM': {'bin': 25.0, 'const': 305.0, 'vars': 76.0, 'rel': -572.18}}
		self.stat = {}
		self.stat['BM'] = {}
		self.stat['HR'] = {}
		for index, row in stat_matrix.iterrows():
			if int(row['iter']) == problem_index:
				self.stat[str(row['algo2'])][str(row['resu2'])] = row['value']
		

		#parse solution 
		solution_matrix = pd.read_sql_query("SELECT * FROM solu", solution)
		#solution is 2 2d matrix 
		#{'HR': {'nodes': 238.0, 'cpu': 20.296, 'LB': -247.11176726119777, 'sol': -247.11176726119757, 'time': 20.338000101037323}, 'BM': {'nodes': 331.0, 'cpu': 0.866, 'LB': -247.11176726119646, 'sol': -247.1117672611966, 'time': 0.9040002012625337}, 'DB_HR': {'LB': -299.38827067059776, 'sol': -247.11176726119777, 'time': 198.77797972876579, 'nodes': 1388.0, 'cpu': 44.74400000000039, 'best': 1380.0, 'first': 913.0}, 'DB_BM': {'LB': -285.57196866617903, 'sol': -247.11176726119777, 'time': 130.62299648299813, 'nodes': 1220.0, 'cpu': 13.76399999999985, 'best': 1212.0, 'first': 883.0}}
		self.solution = {}
		self.solution['BM'] = {}
		self.solution['HR'] = {}
		self.solution['DB_BM'] = {}
		self.solution['DB_HR'] = {}
		for index,row in solution_matrix.iterrows():
			if int(row['iter']) == problem_index:
				self.solution[str(row['algo'])][str(row['resu'])] = row['value']






	def get_features(self):
		self.features = collections.OrderedDict()
		self.features['num_vars'] = self.num_vars
		self.features['average_num_disjuncts_per_disjunction'] = float(self.total_num_disjuncts) / float(self.num_disjunctions)
		self.features['total_num_disjuncts'] = self.total_num_disjuncts
		self.features['num_disjunctions'] = self.num_disjunctions
		self.features['average_sparsity_A'] = self.get_average_A_sparsity()
		self.features['average_num_vars_per_disjunct'] = self.get_average_num_vars_per_disjunct()
		for key in self.stat:
			for key2 in self.stat[key]:
				self.features[key+"_"+key2] = self.stat[key][key2]
		self.features['1_norm_c'] = np.linalg.norm(self.c, ord=1)
		self.features['average_nuclear_norm_over_nconstr_b'] = self.get_average_nuclear_norm_over_nconstr_b()
		
		self.Y = self.get_Y()
		

	def get_average_A_sparsity(self):
		temp = 0.0
		totol_A_count = 0.0
		for i in range(self.num_disjunctions):
			totol_A_count += self.num_disjuncts[i]
			for j in range(int(self.num_disjuncts[i])):
				temp = temp + float(np.count_nonzero(self.A[i][j])) / float(np.prod(self.A[i][j].shape))
		return 1 - temp / totol_A_count

	def get_average_num_vars_per_disjunct(self):
		vars_count = 0.0
		for i in range(self.num_disjunctions):
			for j in range(int(self.num_disjuncts[i])):
				vars_count += np.count_nonzero(np.sum(np.absolute(self.A[i][j]), axis=0))
		return vars_count / self.total_num_disjuncts

	def get_average_nuclear_norm_over_nconstr_b(self):
		total_zero_b = 0.0
		for i in range(self.num_disjunctions):
			for j in range(int(self.num_disjuncts[i])):
				total_zero_b += (float(len(self.b[i][j])) - np.count_nonzero(self.b[i][j]) )  / float(len(self.b[i][j]))
		return total_zero_b / self.total_num_disjuncts

	def get_Y(self):
		if self.solution['DB_HR'].has_key('cpu') and self.solution['DB_BM'].has_key('cpu'):
			if self.solution['DB_HR']['cpu'] < self.solution['DB_BM']['cpu']:
				return 1
			else:
				return 0 
		elif self.solution['DB_BM'].has_key('cpu'):
			return 0 
		else:
			return 1

	def write_features_to_libsvm(self):
		output = open("/home/canl1/work/GDP_Refomulation_NN/features/features_for_libsvm", "a")
		output.write(str(self.Y) + " ")
		i = 1
		for key in self.features:
			output.write(str(i) + ":" + str(self.features[key]) + " ")
			i +=1
		output.write("\n")
		output.close()
		

	def write_features(self):
		f = open("/home/canl1/work/GDP_Refomulation_NN/features/features", "w")
		i = 1
		for key in self.features:
			f.write(str(i)+":" + key + " ")
			i += 1

		














