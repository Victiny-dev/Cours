var joueurs =
    [
        { nom: "Kévin", score : 9, badge:0, propriétés:""},
        { nom: "Blaster", score:18, badge:2, propriétés:"courage, dextérité"},
        { nom: "Nooblivious", score:1, badge:1, propriétés:"fuite discrètes"}
    ]

function genererTableau() {
    document.write("<table> <tbody>")
    for (const joueur of joueurs) {
        document.write("<tr><td>" + joueur.nom+"</td>")
        document.write("<td> score = "+joueur.score+"</td>")
        document.write("<td> badge = " +joueur.badge+"</td>")
        document.write("<td> "+joueur.propriétés+"</td></tr>") 
    }
    document.write("</tbody> </table>")
}