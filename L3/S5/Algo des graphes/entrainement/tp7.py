import unittest
from tp1_partie1_correction import nbSommets
import math

#  ____  _  _ _        _
# |  _ \(_)(_) | _____| |_ _ __ __ _
# | | | | || | |/ / __| __| '__/ _` |
# | |_| | || |   <\__ \ |_| | | (_| |
# |____/|_|/ |_|\_\___/\__|_|  \__,_|
#        |__/

""" Représentation d'un graphe orienté valué
	Le graphe est donné sous forme de liste d'arcs qui sont des triplets [i,j,p(i,j)]
	On construit à partir de cette liste le dictionnaire des listes d'adjacence et le dictionnaire des poids M
"""
def arcToListe(Liste):
	Graphe = dict()
	Matrice = dict()
	for arete in Liste:
		if arete[0] not in Graphe:
			Graphe[arete[0]] = [arete[1]]
		else:
			Graphe[arete[0]].append(arete[1])
		Matrice[arete[0],arete[1]] = arete[2]
	return Graphe,Matrice

""" Retourne les plus courts chemins dans un graphe à partir d'un sommet 
	sous la forme d'un dico des père et d'un dico des distances 
	
	Keyword arguments
	G -- Le graphe sous la forme d'un dico de listes d'adjacence
	M -- Les poids sous la forme d'un dico (x,y): p(x,y)
	s -- Le sommet à partir duquel sont calculés les plus courts chemins
"""
def Dijkstra(Graphe,Poids,sommet):
	#Initialisations
	Dist = dict() # Distance des sommets atteignables depuis s
	Pere = dict() # Arbre collecteur sous la forme dico des pères
	Attente = []

	Dist[sommet] = 0
	Pere[sommet] = sommet
	Attente.append(sommet)

	while Attente:
		somAtt=Attente.pop(0)
		for successeur in Graphe[somAtt]:
			if successeur not in Dist or Dist[somAtt] + Poids[somAtt,successeur] < Dist[successeur]:
				Dist[successeur] = Dist[somAtt] + Poids[somAtt,successeur]
				Pere[successeur] = somAtt
				Attente.append(successeur)

	return (Dist,Pere)

#  ____       _ _
# | __ )  ___| | |_ __ ___   __ _ _ __
# |  _ \ / _ \ | | '_ ` _ \ / _` | '_ \
# | |_) |  __/ | | | | | | | (_| | | | |
# |____/ \___|_|_|_| |_| |_|\__,_|_| |_|
#
""" Amélioration de la fonction arcToListe retournant également 
	la liste des prédécesseurs
"""
def arcToListe2(L):
	P = dict()
	G = dict()
	M = dict()	
	#TODO
	return (P, G,M)

def Bellman(P,G,M,s):
	dist = dict()
	pere = dict()
	#TODO
	return (Dist,Pere)

#___ __ _____ __           ___      __  __ __ 
# | |_ (_  | (_   |  ||\ || |  /\ ||__)|_ (_  
# | |____) | __)  \__/| \|| | /--\|| \ |____) 
#  
class GrapheTest(unittest.TestCase):

	def setUp(self):
		self.listArcs=[ [1,2,10],[1,3,3],[1,5,6],[2,1,0],[3,2,4],[3,5,2],[4,3,1],[4,5,3],[5,2,0] ,[5,6,1],[6,1,2],[6,2,1]]
	
	def testArcToListe(self):
		(G,M)=arcToListe(self.listArcs)
		self.assertEqual(G, {
			1: [2, 3, 5], 2: [1], 3: [2, 5], 
			4: [3, 5], 5: [2, 6], 6: [1, 2]})
		self.assertEqual(M, {
			(1, 2): 10,	(1, 3): 3, 	(1, 5): 6, 	(2, 1): 0,
			(3, 2): 4,	(3, 5): 2,	(4, 3): 1,	(4, 5): 3,
			(5, 2): 0,	(5, 6): 1,	(6, 1): 2,	(6, 2): 1	})
			
	def testDijkstra(self):
		G,M = arcToListe(self.listArcs)
		dist,pere = Dijkstra(G, M, 1)
		self.assertEqual(pere, {1: 1, 2: 5, 3: 1, 5: 3, 6: 5})
		self.assertEqual(dist, {1: 0, 2: 5, 3: 3, 5: 5, 6: 6})
		
	"""def testDijkstra2(self):
		G,M = arcToListe(self.listArcs)
		dist,pere = Dijkstra(G, M, 4)
		self.assertEqual(pere, {4: 4, 3: 4, 5: 4, 2: 5, 6: 5, 1: 2})
		self.assertEqual(dist, {4: 0, 3: 1, 5: 3, 2: 3, 6: 4, 1: 3})"""

if __name__ == '__main__':
    unittest.main()
