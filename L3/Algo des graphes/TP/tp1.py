#!/usr/bin/env python3

import unittest 

# __    __ 
#/_ |  /_ |
# | |   | |
# | |   | |
# | | _ | |
# |_|(_)|_|
#          
def nbSommets(G):
	#TODO
	return 0

def nbAretes(G):
	#TODO
	return 0

def ajoutArete(G, i, j):
	#TODO
	pass

def enleveArete(G, i, j):
	#TODO
	raise ValueError("L'arête n'existe pas")

def deg(G, i):
	#TODO
	return 0

def degre(G):
	#TODO
	return 0

def kuratowski(n):
	return {}
	
# __     ___  
#/_ |   |__ \ 
# | |      ) |
# | |     / / 
# | | _  / /_ 
# |_|(_)|____|
#

def areteToListe(L):
	#TODO
	return {}
	
def listeToMatrice(G,n):
	M = [ [ 0 for i in range(n) ] for j in range(n) ]
	#TODO
	return M

def nonOriente(M):
	#TODO
	return True

def matToListe(M):
	#TODO
	return {}
	
# _______        _         _    _       _ _        _               
#|__   __|      | |       | |  | |     (_) |      (_)              
#   | | ___  ___| |_ ___  | |  | |_ __  _| |_ __ _ _ _ __ ___  ___ 
#   | |/ _ \/ __| __/ __| | |  | | '_ \| | __/ _` | | '__/ _ \/ __|
#   | |  __/\__ \ |_\__ \ | |__| | | | | | || (_| | | | |  __/\__ \
#   |_|\___||___/\__|___/  \____/|_| |_|_|\__\__,_|_|_|  \___||___/
#                                                             
class GrapheTest(unittest.TestCase):

	def setUp(self):
		self.liste = [(1,2),(1,5),(1,5),(2,3),(2,4),(2,4),(3,3),(3,4),(4,5)]  
		self.LAdj = {1:[2,5,5],2:[1,3,4,4],3:[2,3,4],4:[2,2,3,5],5:[1,1,4]}
		self.matrice = [
			[0,1,0,0,2],
			[1,0,1,2,0],
			[0,1,1,1,0],
			[0,2,1,0,1],
			[2,0,0,1,0]]

	def testsBasiques(self):
		#test des fonctions basiques
		self.assertEqual(nbSommets(self.LAdj), 5, 'Décompte erroné des sommets')
		self.assertEqual(nbAretes(self.LAdj), 9, 'Décompte erroné des arêtes')
		self.assertEqual(degre(self.LAdj), {1:3,2:4,3:3,4:4,5:3}, 'Erreur dans le calcul des degrés')


	def testAjoutGeneral(self):
		#Ajoute une arête dans le cas général
		ajoutArete(self.LAdj, 1, 4)
		self.assertEqual(nbAretes(self.LAdj), 10, 'Décompte des arêtes erroné après insertion')
		self.assertIn(1, self.LAdj[4], 'La liste d\'adjacence a été mise à jour de manière erronée')
		self.assertIn(4, self.LAdj[1], 'La liste d\'adjacence a été mise à jour de manière erronée')
		
	def testAjoutReflexif(self):
		#Ajoute une arête réflexive
		ajoutArete(self.LAdj, 1, 1)
		self.assertEqual(nbAretes(self.LAdj), 10, 'Décompte des arêtes erroné après insertion')
		self.assertEqual(self.LAdj[1].count(1), 1, 'La liste d\'adjacence a été mise à jour de manière erronée')

	def testEnleveNA(self):
		#Tentative de suppression d'une arête inexistante
		try:
			enleveArete(self.LAdj, 1, 4)
		except ValueError:
			return
		except:
			pass
		self.fail('Tentative non détectée de supprimer une arête qui n\'existe pas')
		
	def testEnleveGeneral(self):
		#Enlève une arête cas général
		enleveArete(self.LAdj, 1, 2)
		self.assertEqual(nbAretes(self.LAdj), 8, 'Décompte des arêtes erroné après suppression')
		self.assertNotIn(1, self.LAdj[2])

	def testEnleveMulti(self):
		#Enlève une arête multigraphe
		enleveArete(self.LAdj, 2, 4)
		self.assertEqual(self.LAdj[2].count(4), 1, 'Connexité erronée après suppression d\'une arête présente en plusieurs exemplaires')
	
	def testEnleveReflexif(self):
		#Enlève une arête réflexive
		enleveArete(self.LAdj, 3, 3)
		self.assertEqual(nbAretes(self.LAdj), 8,'Décompte des arêtes erroné après suppression')
		self.assertNotIn(3, self.LAdj[3], 'Connexité erronée après suppression d\'une arête réflexive')

	def testKuratowski(self):
		self.assertEqual(kuratowski(1), {1:[]}, 'K_1 erroné')
		self.assertEqual(kuratowski(2), {1:[2],2:[1]}, 'K_2 erroné')
		self.assertEqual(kuratowski(3), {1:[2,3],2:[1,3],3:[1,2]}, 'K_3 erroné')
		for i, l in kuratowski(12).items():
			for j in range(1, 13):
				if i != j:
					self.assertIn(j, l, 'Il manque une ou plusieurs arêtes')
			self.assertNotIn(i, l, 'Présence erronée d\'une arête réflexive')

	def testAreteToListe(self):
		self.assertEqual(areteToListe(self.liste), self.LAdj)

	def testListeToMatrice(self):
		self.assertEqual(listeToMatrice(self.LAdj, 5), self.matrice)

	def testNonOriente(self):
		self.assertTrue(nonOriente(self.matrice))
		self.assertTrue(nonOriente([[0,1,2],[1,0,3],[2,3,0]]))
		self.assertFalse(nonOriente([[0,0,0],[0,0,0],[1,0,0]]))
		
	def testMatToListe(self):
		self.assertEqual(matToListe(self.matrice), self.LAdj)

if __name__ == '__main__':
    unittest.main()
