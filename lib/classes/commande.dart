import 'package:flutter/material.dart';

class Commande {
  int num_commande;
  int id_user;
  int prix;
  String date;
  bool paye;
  bool sortie;
  int id_client;
  int id_local;
  Color color;


  Commande({this.num_commande, this.id_user, this.prix, this.date, this.paye,
    this.id_client, this.id_local, this.sortie}){
    color = Colors.white ;
  }

  Commande.copy(Commande comd){
    this.num_commande = comd.num_commande;
    this.id_user = comd.id_user;
    this.prix = comd.prix;
    this.date = comd.date;
    this.paye = comd.paye;
    this.id_client = comd.id_client;
    this.id_local = comd.id_local;
    this.sortie = comd.sortie;
  }


  Map<String, dynamic> toMap() =>
      {
        "id_client": id_client,
        "num_commande": num_commande,
        "id_user": id_user,
        "prix": prix,
        "date": date,
        "paye": paye,
        "sortie": sortie,
        "id_local": id_local,
      };

  factory Commande.fromMap(Map<String, dynamic> json) =>
      new Commande(
          id_local : json["id_local"],
          num_commande : json["num_commande"],
          prix : json["prix"],
          date : json["date"],
          paye : (json["paye"] == 1) ? true : false,
          id_client : json["id_client"],
          id_user : json["id_user"],
          sortie : (json["sortie"] == 1) ? true : false,
      );

  @override
  String toString() {
    return 'Commande{num_commande: $num_commande, id_user: $id_user, prix: $prix, date: $date, paye: $paye, sortie: $sortie, id_client: $id_client, id_local: $id_local}';
  }

}