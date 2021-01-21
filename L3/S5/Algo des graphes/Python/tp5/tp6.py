import unittest
from tp1_partie1_correction import nbSommets, ajoutArete, enleveArete
from tp3_correction import cyclicRec, isCyclic
import math


def areteToListe(L):
	"""	Transforme une liste d'arêtes en 
		un dictionnaire de listes d'adjacences G et une matrice 
		des poids M représentée comme un dictionnaire ou
		où le poids de chaque arête (i,j) est en M[(i,j)].

    Keyword arguments:
    L -- Une liste d'arêtes, chacune de la forme [i,j,p(i,j)]
    """
	M = dict()
	G = dict()
	for index in L:
		ajoutArete(G,index[0],index[1])

		if not (index[0],index[1]) in M:
			M[index[0],index[1]] = []
		M[index[0],index[1]] = index[2]
		if index[0] != index[1]:
			if not (index[1],index[0]) in M:
				M[index[1],index[0]] = []
			M[index[1],index[0]] = index[2]
	return (G,M)

#  _  __               _         _ 
# | |/ /_ __ _   _ ___| | ____ _| |
# | ' /| '__| | | / __| |/ / _` | |
# | . \| |  | |_| \__ \   < (_| | |
# |_|\_\_|   \__,_|___/_|\_\__,_|_|
# 
def Kruskal(n,L):
	"""	Calcule l'arbre couvrant du graphe L par l'algorithme 
		de Kruskal. Retourne l'arbre couvrant sous la forme 
		d'un dico de listes d'adjacence T, ainsi que son poids.

    Keyword arguments:
    n -- Le nombre de sommets du graphe
    L -- Une liste d'arêtes, chacune de la forme [i,j,p(i,j)]
    """
	T = dict()
	L = sorted(L, key=lambda x : x[2])
	poids=0
	comp=0
	while len(T) != n :
		ajoutArete(T,L[comp][0],L[comp][1])
		poids+=L[comp][2]
		if isCyclic(T):
			enleveArete(T,L[comp][0],L[comp][1])
			poids-=L[comp][2]
		comp+=1
	return (T,poids)

#  ____       _           
# |  _ \ _ __(_)_ __ ___  
# | |_) | '__| | '_ ` _ \ 
# |  __/| |  | | | | | | |
# |_|   |_|  |_|_| |_| |_|
#
def SommetMin(D):
	#On cherche la clé plus petite valeur de la plus petite valeur non nulle
	#On trie le dictionnaire par ordre croissant de clé
	D = dict(sorted(x.items(), key=lambda item: item[1]))
	for s in D:
		if D[s] !=0:
			#On retourne la première clé de valeur non nulle
			return s
def Prim(L):
	"""	Calcule l'arbre couvrant du graphe L par l'algorithme 
		de Prim. Retourne l'arbre couvrant sous la forme 
		d'un dico de listes d'adjacence T, ainsi que son poids.

    Keyword arguments:
    L -- Une liste d'arêtes, chacune de la forme [i,j,p(i,j)]
    """
	T = dict()
	poids = 0 
	G,M = areteToListe(L)
	D = dict()
	MIN= dict
	#On initialise la distance a tout les points comme étant +inf
	for s in L:
		D[s] = float('inf')
	#A partir du sommet 1, on va définir les distance de lui même et ses voisins
	D[0] = 0
	for i in G[0]:
		D[i] = M[(0,i)]
	

    #	Tant qu'on n'a pas ajouté n-1 arêtes:
	while len(T) != n-1:
    #    On cherche le sommet y de M qui minimise Dist[y]=
    #    On sait que z=Min[y] est tel que l'arête(y,z)

    #    soit l'arête de poids minimal entre un sommet de C et

    #   un sommet de M.

    #    On ajoute l'arête (y,z) à T, y quitte M (Dist[y] = 0)

    #    On met à jour Dist et Min du fait de la présence de y dans C.

	
	



	return (T, poids)
	
	
#___ __ _____ __           ___      __  __ __ 
# | |_ (_  | (_   |  ||\ || |  /\ ||__)|_ (_  
# | |____) | __)  \__/| \|| | /--\|| \ |____) 
#                                             
class GrapheTest(unittest.TestCase):

	def setUp(self):
		self.ListAretes=[[1,2,7],[1,5,6],[1,6,2],[2,3,4],[2,5,5],[3,4,1],[3,5,2],[4,5,3],[5,6,1]]
		##
		self.G6 = {1:[2,5,6],2:[1,3,5],3:[2,4,5],4:[3,5],5:[1,2,3,4,6],6:[1,5]}
		self.G6mat = {
			(1,2):7, (1,5):6, (1,6):2, (2,3):4, (2,5):5, 
			(3,4):1, (3,5):2, (4,5):3, (5,6):1, 
			(2,1):7, (5,1):6, (3,2):4, (5,2):5, (4,3):1, 
			(5,3):2, (5,4):3, (6,1):2, (6,5):1,
		}
	
	def testAreteToListe(self):
		(G,M)=areteToListe(self.ListAretes)
		self.assertEqual(G, self.G6)
		self.assertEqual(M, self.G6mat)
	
	def testKruskal(self):
		(T, poids) = Kruskal(6,self.ListAretes)
		self.assertEqual(T, {1:[6], 2:[3], 3:[4, 5, 2], 4:[3], 5:[6, 3], 6:[5, 1]})
		self.assertEqual(poids, 10)
	
	def testPrim(self):
		(T, poids) = Prim(self.ListAretes)
		self.assertEqual(T, {1:[6], 2:[3], 3:[5, 4, 2], 4:[3], 5:[6, 3], 6:[1, 5]})
		self.assertEqual(poids, 10)

if __name__ == '__main__':
    unittest.main()


                                 
                    
