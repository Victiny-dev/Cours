"""
Question 0.2 : 
    (J, M, 100) les cordonnées YUV d’un pixel d’une image vidéo.
    En utilisant les équations de conversion et à l’aide de Python,
    calculez les cordonnées de la couleur correspondantes dans le diagramme
    de chromaticité xyz ."""

def ConvYUVtoXYZ():
    J = 0 #Valeur de test, à remplacer
    M = 0 #Valeur de test, à remplacer
    I = 100 #Vleur définie dans le sujet (J,M,100) 
    #fonction de conversion d'un code YUV en chromacité xyz
    x,y,z=0
    return x,y,z

"""
Question 0.3 : 
    ligne(im) qui prend en entrée une image RGB de dimension
    640 * 640 et rajoute une ligne verticale noire sur la ligne J 
    et une ligne verticale blanche sur la colonne M. 

    Le but va être de mettre le RGB de tout les pixels ayant pour
    localisation (n,J) (avec n qui varie de 0 à 640) en blanc
    et ceux (M,n) (avec n qui varie de 0 à 640) en noir pour 
    la ligne blanche verticale et la noir horizontale.
"""
def ligne(image) :
    #Je considère une image comme étant un tableau à 2 dimension tel que :
    #image[i,j] donne 3 entiers compris entre 0 et 255 (image[i,j] -> R,V,B)

    
    M = 60 #Valeur de test, à remplacer
    J = 30 #Valeur de test, à remplacer

    for n in range(0,640):
        image[n,J] = 255,255,255 #RVB à 255,255,255 pour le blanc
        image[M,n] = 255,255,255 #RVB à 0,0,0 pour le noir
    return

