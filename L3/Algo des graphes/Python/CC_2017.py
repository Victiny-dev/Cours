
# # Partie 1 : Sur les arborescences
# 
# On considÃ¨re une forÃªt d'arborescence donnÃ©e par son tableau des pÃ¨res
# 
# 1) Ecrire une fonction de conversion tableau des pÃ¨res -> liste d'adjacences

def tabPereToListe(P) :
    M={}
    for index in range(1,len(P)):
        if index not in M:
            M[index] = []
        if index != P[index]:
            M[P[index]].append(index)
    return M

####Test : 
P = [0,1,1,2,2,5,5,5,6,6,9,9]
G = tabPereToListe(P)
print("Le tableau des peres : " , P)
print()
print("Sa reprÃ©sentation par liste d'adjacences : ")
print(G)



# 2) Ecrire une fonction ancÃªtres qui dÃ©termine les ancÃªtres d'un sommet y dans l'arbre


def ancetres(y,P):
    parcours=1
    tab=[]
    


    return 0
####Test : 
print("Les ancÃªtres du sommet 9 sont : " , ancetres(9,P))
print("Ceux du sommet 11 sont : ", ancetres(11,P))
print("Ceux de 4 sont : ", ancetres(4,P))
print("Ceux de 1 sont : ", ancetres(1,P))
print("Ceux de 2 sont :", ancetres(2,P))


# 3) Ecrire une fonction ancetre(x,y,G) valant vrai si x est un ancetre de y
def ancetre(x,y,P):

    return 0

####Test : 
print(" 1 est-il ancÃªtre de  4 ?" , ancetre(1,4,P))
print("1 est-il ancÃªtre de  5 ?" , ancetre(1,5,P))
print("6 est-il ancÃªtre de  11 ?", ancetre(6,11,P))


################
# Partie 2 - Parcours en profondeur
#

# 1) Ecrire le parcours en profondeur gÃ©nÃ©ralisÃ©
# La fonction doit renvoyer le tableau des pÃ¨res de la forÃªt de parcours. 



def profRec(G,i,Visite,Pere) :
    Visite.append(i)
    for s in G:
        if s not in Visite:
            Pere.append(i)
            profRec(G,s,Visite,Pere)
    pass

def profondG(G):
    Visite = []
    Pere=[]
    for i in G:
        if i not in Visite:
            profRec(G,i,Visite,Pere)
        
    return Pere

# Test sur le graphe G
G = [[],[2],[3,4],[1],[2],[6,7,8,9],[4,8,9],[9,10],[],[8,10,11],[5],[]] 
P = profondG(G)
print()
print("La forÃªt de parcours est donnÃ©e par le tableau des pÃ¨res : " , P)

################
# Partie 3 - Parcours en profondeur et classification des arcs
# 

# On travaille par dadaptations successives des fonctions de parcours
# On fournit dans ce corrigÃ© les trois Ã©tapes :

# 1) arcs couvrants vs revisites
def profRec1(G,i,Visite,Pere) :

    return 0

def profondG1(G):

    return 0

# Test sur le graphe G
print()
print("Recherche des arcs couvrants :  ")
P = profondG1(G)


# 2) dÃ©tection des arcs arriÃ¨res
# On dÃ©tecte un arc arriÃ¨re si le parcours est commencÃ© mais pas terminÃ©
# On utilise Visite = 0 si le parcours n'est pas commencÃ©
#                   = 1 s'il est commencÃ© mais pas terminÃ©
#                   = 2 s'il est terminÃ©

def profRec2(G,i,Visite,Pere) :
    return 0

def profondG2(G):

    # Test sur le graphe G
    print()
    print("Recherche des arcs couvrants et arriÃ¨re:  ")
    P = profondG2(G)
    return 0


# 3) dÃ©tection des arcs avant
# On dÃ©tecte un arc avant si on revisite un sommet qui est un de nos descendant
# dans la forÃªt de visite
def profRec3(G,i,Visite,Pere) :
    return 0

def profondG3(G):
    
    # Test sur le graphe G
    print()
    print("Classification complÃ¨te des arcs :  ")
    P = profondG3(G)
    return 0