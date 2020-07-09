import './commande.dart';

class LigneCommande {
  String reference;
  int quantite;
  int id_service;
  int num_commande;
  int prix;


  LigneCommande({this.reference, this.quantite, this.id_service,
    this.num_commande,this.prix});

  LigneCommande.copy(LigneCommande ligcmd){
    this.reference = ligcmd.reference;
    this.quantite = ligcmd.quantite;
    this.id_service = ligcmd.id_service;
    this.num_commande = ligcmd.num_commande;
    this.prix = ligcmd.prix;
  }

  factory LigneCommande.fromMap(Map<String, dynamic> json) =>
      LigneCommande(
        reference : json["reference"],
        num_commande : int.parse(json["num_commande"]),
        quantite : int.parse(json["quantite"]),
        id_service : int.parse(json["id_service"]),
        prix : int.parse(json["prix"]),
      );

  @override
  String toString() {
    return 'LigneCommande{reference: $reference, quantite: $quantite, id_service: $id_service, num_commande: $num_commande, prix: $prix}';
  }

  Map<String, dynamic> toMap() =>
      {
        "reference": reference,
        "num_commande": num_commande,
        "prix": prix,
        "quantite": quantite,
        "id_service": id_service,
      };



}