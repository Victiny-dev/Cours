<?php
$pourcentage = $_POST['pourcentage'];

include "connexion.php";

// ajout d'un étudiant
$req = $bdd->prepare(' SELECT *  FROM ville');
$res = $req->execute();

if ($res == false) {
    echo "\nPDOStatement::errorInfo():\n";
    $arr = $req->errorInfo();
    print_r($arr);
} else {
    while ($donnees = $req->fetch()) {
        $nb=$donnees['ville_population_2012'];
        $ville_id=$donnees['ville_id'];
        
        $nb_ecoles=(int)($nb*$pourcentage/100);
        // ecriture nouvelle valeur
        $req1 = $bdd->prepare('UPDATE ville SET  nb_ecoles = :nb_ecoles WHERE ville_id = :ville_id');

        $res1 = $req1->execute(array('ville_id' => $ville_id,'nb_ecoles' => $nb_ecoles));
        if ($res == false) {
            echo "\nPDOStatement::errorInfo():\n";
            $arr = $req->errorInfo();
            print_r($arr);
        }
    }

}
