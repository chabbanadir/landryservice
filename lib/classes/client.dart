class Client{
  int id_client;
  String nom_client="";
  String prenom_client;
  String num_telephone;
  String mail_client;
  bool fidel;

  static List<dynamic> clients;

  Client({this.nom_client, this.prenom_client,
      this.num_telephone, this.fidel,this.mail_client, this.id_client});

  Client.copy(Client cl1){
    id_client = cl1.id_client;
    nom_client = cl1.nom_client;
    prenom_client = cl1.prenom_client;
    num_telephone = cl1.num_telephone;
    mail_client = cl1.mail_client;
    fidel = cl1.fidel;
  }

  @override
  String toString() {
    return 'Client{id_client: $id_client, nom_client: $nom_client, prenom_client: $prenom_client, num_telephone: $num_telephone, mail_client: $mail_client, fidel: $fidel}';
  }

  Map<String, dynamic> toMap() => {
    "id_client": id_client,
    "nom_client": nom_client,
    "prenom_client": prenom_client,
    "num_telephone": num_telephone,
    "mail_client": mail_client,
    "fidel": fidel,
  };

  factory Client.fromMap(Map<String, dynamic> json) =>  Client(
    id_client: json["id_client"],
    nom_client: json["nom_client"],
    prenom_client: json["prenom_client"],
    num_telephone: json["num_telephone"],
    mail_client: json["mail_client"],
    fidel: (json["fidel"] == 1) ? true : false,
  );
  factory Client.fromMap2(Map<String, dynamic> json) =>  Client(
    id_client: int.parse(json["id_client"]),
    nom_client: json["nom_client"],
    prenom_client: json["prenom_client"],
    num_telephone: json["num_telephone"],
    mail_client: json["mail_client"],
    fidel: (json["fidel"] == 1) ? true : false,
  );

}