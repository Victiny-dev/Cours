<!DOCTYPE html>
<html>
<link href="style.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="index.js"> </script>

<?php
include "connexion.php";

// on stocke les données dont on aura besoin dans des tableaux
$reponse = $bdd->query('SELECT *  FROM ville join departement on ville.ville_departement=departement.departement_code order by ville_nom');
while ($donnees = $reponse->fetch()) {
    $tab_nom[$donnees['ville_id']] = $donnees['ville_nom'];
    $tab_departement[$donnees['ville_id']] = $donnees['departement_nom'];
    $tab_pop1999[$donnees['ville_id']] = $donnees['ville_population_1999'];
    $tab_pop2012[$donnees['ville_id']] = $donnees['ville_population_2012'];
    $tab_nb_ecoles[$donnees['ville_id']] = $donnees['nb_ecoles'];
}
?>

<head>
    <meta charset="UTF-8">
    <title>Evaluation 1</title>
</head>

<body>
    <h1>Liste des villes françaises de plus de 40 000 habitants</h1>

    Choix du pourcentage d'écoles dans les villes
    <form id="pourcentage_ecoles" action="modifier_ecoles.php" method="post">
        <p><input required id="pourcentage" type=text name="pourcentage"></p>
        <p hidden><input type="submit" value="Valider"></p>
    </form>
    <?php

    // affichage du tableau
    echo '<TABLE cellpadding=3 border=2>';
    echo '<FONT size="+2"><tr><th>Nom</th><th>Département</th><th>Population 1999</th><th>Population 2012</th><th>Nombre d\'écoles</th></tr>';
    echo '<tr><td ><select id="filtre"><option>Toutes</option><option>Croissantes</option><option>Décroissantes</option></select></td><td></td><td></td><td></td><td></td></tr>';

    foreach ($tab_nom as $ville_id => $nom) {
        if ($tab_pop1999[$ville_id] < $tab_pop2012[$ville_id])
            $type = 'croissante';
        else
            $type = 'decroissante';
        echo '<tr class=' . $type . '><td >' . $nom . '</td><td>' . $tab_departement[$ville_id] . '</td><td>' . $tab_pop1999[$ville_id] . '</td><td>' . $tab_pop2012[$ville_id] . '</td><td class="ecole">' . $tab_nb_ecoles[$ville_id] . '</td></tr>';
    }


    echo '</TABLE>';

    ?>
</body>

</html>