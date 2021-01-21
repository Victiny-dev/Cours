import unittest
from tp1_partie1_correction import nbSommets, ajoutArete, enleveArete
from tp3_correction import cyclicRec, isCyclic
import math


def areteToListe(ListeArete):
	"""	Transforme une liste d'arêtes en 
		un dictionnaire de listes d'adjacences Graphe et une matrice 
		des poids Matrice représentée comme un dictionnaire ou
		où le poids de chaque arête (i,j) est en M[(i,j)].

    Keyword arguments:
    ListeArete -- Une liste d'arêtes, chacune de la forme [i,j,p(i,j)]
    """
	Graphe = dict()
	Matrice = dict()
	for arete in ListeArete:
		ajoutArete(Graphe,arete[0],arete[1])
		if (arete[0],arete[1]) not in Matrice:
			Matrice[arete[0],arete[1]] = arete[2]
		else:
			Matrice[arete[0],arete[1]].append(arete[2])
		if arete[0] != arete[1]:
			if (arete[1],arete[0]) not in Matrice:
				Matrice[arete[1],arete[0]] = arete[2]
			else:
				Matrice[arete[1],arete[0]].append(arete[2])
	return (Graphe,Matrice)

#  _  __               _         _ 
# | |/ /_ __ _   _ ___| | ____ _| |
# | ' /| '__| | | / __| |/ / _` | |
# | . \| |  | |_| \__ \   < (_| | |
# |_|\_\_|   \__,_|___/_|\_\__,_|_|
# 
def Kruskal(nbSommet,ListeArete):
	"""	Calcule l'arbre couvrant du graphe L par l'algorithme 
		de Kruskal. Retourne l'arbre couvrant sous la forme 
		d'un dico de listes d'adjacence ListeAdj, ainsi que son poids.

    Keyword arguments:
    nbSommet -- Le nombre de sommets du graphe
    ListeArete -- Une liste d'arêtes, chacune de la forme [i,j,p(i,j)]
    """
	ListeArete = sorted(ListeArete, key=lambda x : x[2])
	ListeAdj = dict()
	poids=0

	while len(ListeAdj) != nbSommet:
		arete=ListeArete.pop(0)
		ajoutArete(ListeAdj,arete[0],arete[1])
		poids += arete[2]
		if isCyclic(ListeAdj) :
			enleveArete(ListeAdj,arete[0],arete[1])
			poids-=arete[2]

	return (ListeAdj,poids)

#  ____       _           
# |  _ \ _ __(_)_ __ ___  
# | |_) | '__| | '_ ` _ \ 
# |  __/| |  | | | | | | |
# |_|   |_|  |_|_| |_| |_|
#     
def Prim(L:list):
    """Calcule l'arbre couvrant du graphe L par l'algorithme 
    de Prim. Retourne l'arbre couvrant sous la forme 
    d'un dico de listes d'adjacence T, ainsi que son poids.

    Parameters
    ----------
    L : list
        Une liste d'arêtes, chacune de la forme [i,j,p(i,j)]
    
    Returns
    -------
    T : dict
        Arbre résultat
    poidsTotal : int
        Poids de l'arbre final
    """
    (G,M) = areteToListe(L)
    n = len(G)
    T = dict((i,[]) for i in G)
    poidsTotal = 0
    nombreArete = 0
    # Initialisation x=1
    Dist = dict((i,float('inf')) for i in G)
    Min = dict((i,1) for i in G)
    # Un sommet y est dans C si Dist[y] = 0 et dans M sinon
    Dist[1]=0
    for voisin in G[1]:
        Dist[voisin]=M[(1,voisin)]
    # Tant qu'on n'a pas ajouté n-1 arêtes (ici 5)
    while nombreArete<n-1:
    # On cherche le sommet y de M qui minimise Dist[y]
        y=minimise(Dist)
    # On sait que z=Min[y] est tel que l'arête (y,z)
    # soit l'arête de poids minimal entre un sommet de C et un sommet de M
        z=Min[y]
    # On ajoute l'arête (y,z) à T, y quitte M (Dist[y]=0)
        ajoutArete(T,y,z)
        nombreArete += 1
        poidsTotal += Dist[y]
    # On met à jour Dist et Min du fait de la présence de y dans C
        Dist[y]=0
        for voisin in G[y]:
            if Dist[voisin]>M[(y,voisin)]:
                Dist[voisin]=M[(y,voisin)]
                Min[voisin]=y
    return (T, poidsTotal)
	
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

	"""def testPrim(self):
		(T, poids) = Prim(self.ListAretes)
		self.assertEqual(T, {1:[6], 2:[3], 3:[5, 4, 2], 4:[3], 5:[6, 3], 6:[1, 5]})
		self.assertEqual(poids, 10)
"""
if __name__ == '__main__':
    unittest.main()


                                 
                    
