#!/usr/bin/env python3

import unittest
from tp2_correction import *

def nbSommets(G):
	return len(G)-1				

#  _   _                          _            _    __      
# | \ | |                        (_)          | |  /_/      
# |  \| | ___  _ __     ___  _ __ _  ___ _ __ | |_ ___  ___ 
# | . ` |/ _ \| '_ \   / _ \| '__| |/ _ \ '_ \| __/ _ \/ __|
# | |\  | (_) | | | | | (_) | |  | |  __/ | | | ||  __/\__ \
# |_| \_|\___/|_| |_|  \___/|_|  |_|\___|_| |_|\__\___||___/
#
def isConnexe(G):
	return False

def cyclicRec(G, i, pere, Visite):
	return False
	
def isCyclic(G):
	return False
	
def isArbre(G):
	return False
	
def plusCourtChemin(G, i):
	return ([], [])

def biparti(G):
	return (False, [], [])

#              _            _    __      
#             (_)          | |  /_/      
#    ___  _ __ _  ___ _ __ | |_ ___  ___ 
#   / _ \| '__| |/ _ \ '_ \| __/ _ \/ __|
#  ( (_) | |  | |  __/ | | | ||  __/\__ \
#   \___/|_|  |_|\___|_| |_|\__\___||___/
#                                                         
def cyclicRecOriente(G, i, Visite):
	return False

def isCyclicOriente(G):
	return False


# _______        _         _    _       _ _        _               
#|__   __|      | |       | |  | |     (_) |      (_)              
#   | | ___  ___| |_ ___  | |  | |_ __  _| |_ __ _ _ _ __ ___  ___ 
#   | |/ _ \/ __| __/ __| | |  | | '_ \| | __/ _` | | '__/ _ \/ __|
#   | |  __/\__ \ |_\__ \ | |__| | | | | | || (_| | | | |  __/\__ \
#   |_|\___||___/\__|___/  \____/|_| |_|_|\__\__,_|_|_|  \___||___/
#                                                             
class GrapheTest(unittest.TestCase):

	def setUp(self):
		self.G1=[[],[2],[1,3,7],[2],[7],[7],[7],[2,4,5,6]] 		# arbre
		self.G2=[[],[2,4],[1,3,7],[2],[1,7],[7],[7],[2,4,5,6]]	# connexe cyclique
		self.G3=[[],[2],[1,3],[2],[7],[7],[7],[4,5,6]]			# ni connexe ni cyclique
		self.G4=[[],[2],[1,3],[2],[5,7],[4,7],[7],[4,5,6]] 		# pas connexe cyclique
	
	def testConnexe(self):
		self.assertTrue(isConnexe(self.G1))
		self.assertTrue(isConnexe(self.G2))
		self.assertFalse(isConnexe(self.G3))
		self.assertFalse(isConnexe(self.G4))

	def testCyclic(self):
		self.assertTrue(isCyclic([[],[2,3], [1,3], [1,2]]))
		self.assertFalse(isCyclic([[], [2], [1,3], [2]]))
		self.assertFalse(isCyclic(self.G1))
		self.assertTrue(isCyclic(self.G2))
		self.assertFalse(isCyclic(self.G3))
		self.assertTrue(isCyclic(self.G4))

	def testArbre(self):
		self.assertTrue(isArbre([[],[2,3],[1],[1]]))
		self.assertTrue(isArbre(self.G1))
		self.assertFalse(isArbre(self.G2))
		self.assertFalse(isArbre(self.G3))
		self.assertFalse(isArbre(self.G4))

	def testPlusCourtChemin(self):
		res = plusCourtChemin(self.G1, 1)
		self.assertEqual(res[0][1:], [0,1,2,3,3,3,2])
		self.assertEqual(res[1][1:], [1,1,2,7,7,7,2])
		res = plusCourtChemin(self.G1, 3)
		self.assertEqual(res[0][1:], [2,1,0,3,3,3,2])
		res = plusCourtChemin(self.G4, 1)
		self.assertEqual(res[0][1:], [0,1,2,-1,-1,-1,-1])
		res = plusCourtChemin(self.G4, 5)
		self.assertEqual(res[0][1:], [-1,-1,-1,1,0,2,1])

	def testBiparti(self):
		self.assertEqual(biparti([[],[2,3],[1],[1]]), (True,[1],[2,3]))
		self.assertEqual(biparti([[],[4],[3],[2],[1]]), (True,[1,2],[4,3]))
		self.assertEqual(biparti(self.G1), (True, [1,3,7], [2,4,5,6]))
		self.assertEqual(biparti(self.G2), (True, [1,3,7], [2,4,5,6]))
		self.assertEqual(biparti(self.G3), (True, [1,3,4,5,6], [2,7]))
		self.assertEqual(biparti(self.G4), (False, [], []))
		
	def testIsCyclicOriente(self):
		self.assertTrue(isCyclicOriente([[],[3,4,5,6],[1],[2,4],[],[],[4]]))
		self.assertFalse(isCyclicOriente([[],[4,5,6],[1],[2,4],[],[],[4]]))


if __name__ == '__main__':
    unittest.main()


