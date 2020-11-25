#!/usr/bin/env python3

import unittest
import time
import copy

#  _____     _   _                    _             _                  
# |_   _| __(_) | |_ ___  _ __   ___ | | ___   __ _(_) __ _ _   _  ___ 
#   | || '__| | | __/ _ \| '_ \ / _ \| |/ _ \ / _` | |/ _` | | | |/ _ \
#   | || |  | | | || (_) | |_) | (_) | | (_) | (_| | | (_| | |_| |  __/
#   |_||_|  |_|  \__\___/| .__/ \___/|_|\___/ \__, |_|\__, |\__,_|\___|
#                        |_|                  |___/      |_|     
# 

def degE(G, i):
    cpt = 0
    for k in G:
        for e in G[k]:
            if e == i:
                cpt+=1
    return cpt

def degreE(G):
    D = {}
    for k in G:
        D[k] = degE(G, k)
    return D

def triTopo(G):
	S= []
	T= []
	#Calcul des degrès entrants 
	deg=(degreE(G))
	#Calcul des sources
	for s in deg:
		if deg[s] == 0 :
			S.append(s)
	#Continuer tant qu'il y a des sources
	while S:
		i = S.pop(0)
		T.append(i)
		#Decrément le degrès entrant de tout ses voisins
		for j in G[i]:
			deg[j]-=1
			if deg[j] == 0:
				S.append(j)
	if len(T) == len(G):
		return T
	else:
		raise RuntimeError("Cycle detecté")

#  _____     _                            _                            
# |_   _| __(_)  _ __   __ _ _ __   _ __ (_)_   _____  __ _ _   ___  __
#   | || '__| | | '_ \ / _` | '__| | '_ \| \ \ / / _ \/ _` | | | \ \/ /
#   | || |  | | | |_) | (_| | |    | | | | |\ V /  __/ (_| | |_| |>  < 
#   |_||_|  |_| | .__/ \__,_|_|    |_| |_|_| \_/ \___|\__,_|\__,_/_/\_\
#               |_|                                                    
def triNiveaux(G):
	#
	N1= []
	T= []
	cpt=0
	#Calcul des degrès entrants 
	deg=(degreE(G))
	#Calcul des sources
	for s in deg:
		if deg[s] == 0 :
			N1.append(s)
	#Continuer tant qu'il y a des sources
	while N1:
		T.append(N1)
		cpt+=len(N1)
		N2= []
		for i in N1:			
			for j in G[i]:
				deg[j]-=1
				if deg[j] == 0:
					N2.append(j)
		N1=copy.deepcopy(N2)
	if cpt == len(G):
		return T
	else:
		raise RuntimeError("Cycle detecté")
	
# _______        _         _    _       _ _        _               
#|__   __|      | |       | |  | |     (_) |      (_)              
#   | | ___  ___| |_ ___  | |  | |_ __  _| |_ __ _ _ _ __ ___  ___ 
#   | |/ _ \/ __| __/ __| | |  | | '_ \| | __/ _` | | '__/ _ \/ __|
#   | |  __/\__ \ |_\__ \ | |__| | | | | | || (_| | | | |  __/\__ \
#   |_|\___||___/\__|___/  \____/|_| |_|_|\__\__,_|_|_|  \___||___/
#   
class GrapheTest(unittest.TestCase):

	def setUp(self):
		self.simple = {1:[2],2:[3],3:[]}
		self.simple2 = {1:[2,3],2:[],3:[]}
		self.cyclique = {1:[2],2:[3],3:[4],4:[2]}
		self.G = {1:[2,6],2:[3,5,6],3:[4,5],4:[],5:[4],6:[5],7:[2,6]}
		self.G2 = {1:[2,7],2:[6],3:[2,4,5],4:[5],5:[],6:[5,7],7:[]}
	
	def testTriTopo(self):
		self.assertEqual(triTopo(self.G), [1,7,2,3,6,5,4])
		self.assertEqual(triTopo(self.simple), [1,2,3])
		

	def testTriTopoCyclique(self):
		try:
			triTopo(self.cyclique)
		except RuntimeError:
			return
		except:
			pass
		self.fail('Tentative de tri topologique d\'un graphe cyclique')

	def testTriNiveaux(self):
		self.assertEqual(triNiveaux(self.simple), [[1], [2], [3]])
		self.assertEqual(triNiveaux(self.simple2), [[1],[2,3]])
		self.assertEqual(triNiveaux(self.G), [[1,7],[2],[3,6],[5],[4]])
		self.assertEqual(triNiveaux(self.G2), [[1,3],[2,4],[6],[5,7]])

if __name__ == '__main__':
    unittest.main()
