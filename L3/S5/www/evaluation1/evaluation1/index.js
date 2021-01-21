$(function () {

    $("#pourcentage_ecoles").on("submit", function (event) {
        event.preventDefault();
        data = $(this).serialize();
        console.log(data)
        $.ajax({
            url: 'modifier_ecoles.php',
            type: 'POST',
            data: data,
            dataType: 'text',
            success: function (resultat, statut) {
                if (resultat != "") alert(resultat); // erreur dans la requête sql
                else {
                    // on rafraichit la page ...
                    //self.location.href = "index.php";

                    // ... ou on met à jour la colonne nb ecoles
                    var pourcentage=parseFloat($("#pourcentage").val());
                    console.log("pourc="+pourcentage);
                    $(".ecole").each(function() {
                        pop=parseInt($(this)[0].previousSibling.innerHTML);
                        console.log(pop);
                        $(this).html(Math.floor(pop*pourcentage/100));
                    });

                }
            },
            // erreur dans la requête http
            error: function (resultat, statut, erreur) {
                console.log(resultat);
                alert(erreur);
            }
        });
    });


    $('#filtre').change(function () {
        val = $(this).val();
        if (val=="Croissantes"){            
            $(".croissante").show();
            $(".decroissante").hide();
        }
        if (val=="Décroissantes"){            
            $(".croissante").hide();
            $(".decroissante").show();
        }
        if (val=="Toutes"){            
            $(".croissante").show();
            $(".decroissante").show();
        }
    });



});
