#!/usr/bin/env python3

import unittest
import copy

#  _____     _   _                    _             _                  
# |_   _| __(_) | |_ ___  _ __   ___ | | ___   __ _(_) __ _ _   _  ___ 
#   | || '__| | | __/ _ \| '_ \ / _ \| |/ _ \ / _` | |/ _` | | | |/ _ \
#   | || |  | | | || (_) | |_) | (_) | | (_) | (_| | | (_| | |_| |  __/
#   |_||_|  |_|  \__\___/| .__/ \___/|_|\___/ \__, |_|\__, |\__,_|\___|
#                        |_|                  |___/      |_|           

def degE(Graphe):
	deg = dict()
	for sommet in Graphe:
		deg[sommet] = 0 
	for sommet in Graphe:
		for voisin in Graphe[sommet] :
			deg[voisin] +=1
	return deg

def triTopo(Graphe):
	deg = degE(Graphe)
	source= []
	tri = []
	for sommet in deg:
		if deg[sommet] == 0:
			source.append(sommet)
	while source:
		element = source.pop(0)
		tri.append(element)
		for degchangeant in Graphe[element]:
			deg[degchangeant] -=1
			if deg[degchangeant] == 0:
				source.append(degchangeant)
	if len(tri) != len(Graphe):
		raise RuntimeError()
	return tri
		
#  _____     _                            _                            
# |_   _| __(_)  _ __   __ _ _ __   _ __ (_)_   _____  __ _ _   ___  __
#   | || '__| | | '_ \ / _` | '__| | '_ \| \ \ / / _ \/ _` | | | \ \/ /
#   | || |  | | | |_) | (_| | |    | | | | |\ V /  __/ (_| | |_| |>  < 
#   |_||_|  |_| | .__/ \__,_|_|    |_| |_|_| \_/ \___|\__,_|\__,_/_/\_\
#               |_|                                                    
def triNiveaux(Graphe):
	Niveau = set()
	N1 = []
	deg = degE(Graphe)
	for sommet in deg:
		if deg[sommet] == 0 :
			N1.append(sommet)
	while N1 : 
		Niveau.add(N1)
		N2 = []
		for sommet in N1:
			for degChangeant in Graphe[sommet]:
				deg[degChangeant] -=1
				if deg[degChangeant] == 0:
					N2.append(degChangeant)
		N1 = copy.deepcopy(N2)
	
	return Niveau
	
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
		self.assertEqual(triTopo(self.simple), [1,2,3])
		self.assertEqual(triTopo(self.G), [1,7,2,3,6,5,4])

	def testTriTopoCyclique(self):
		try:
			triTopo(self.cyclique)
		except RuntimeError:
			return
		except:
			pass
		self.fail('Tentative de tri topologique d\'un graphe cyclique')

	def testTriNiveaux(self):
		self.assertEqual(triNiveaux(self.simple), [{1},{2},{3}])
		self.assertEqual(triNiveaux(self.simple2), [{1},{2,3}])
		self.assertEqual(triNiveaux(self.G), [{1,7},{2},{3,6},{5},{4}])
		self.assertEqual(triNiveaux(self.G2), [{1,3},{2,4},{6},{5,7}])

if __name__ == '__main__':
    unittest.main()
