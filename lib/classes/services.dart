class Services{
  int id_service;
  String nom_service;
  int prix;
  int prix_fidel;

  Services({this.id_service,this.nom_service,this.prix,this.prix_fidel});
  Services.copy(Services serv){
    this.nom_service =serv.nom_service;
    this.prix = serv.prix;
    this.id_service = serv.id_service;
    this.prix_fidel = serv.prix_fidel;
  }

  factory Services.fromMap(Map<String, dynamic> json) =>
      Services(
        nom_service : json["nom_service"],
        id_service : json["id_service"],
        prix : json["prix"],
        prix_fidel: json["sechable"] ,
      );

  Map<String, dynamic> toMap() =>
      {
        "nom_service": nom_service,
        "prix": prix,
        "id_service": id_service,
        "prix_fidel" : prix_fidel,
      };

}
