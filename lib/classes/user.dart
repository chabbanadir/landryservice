class User {
  int id;
  String nom;
  String prenom;
  String cin;
  String status;
  int id_local;

  static User curentUser;


  User({this.id_local,this.id,this.cin,this.nom,this.prenom,this.status}) {
    curentUser = this;
  }


  User.map(List<dynamic> data){
    id_local = int.parse(data[0]['id_local']);
    id = int.parse(data[0]['id_user']);
    nom = data[0]['nom_user'];
    prenom = data[0]['prenom_user'];
    cin = data[0]['cin'];
    status =data[0]['status'];
    curentUser = this;
  }

  @override
  String toString() {
    return '$id $nom $prenom $cin $status $id_local';
  }

  factory User.fromMap(Map<String, dynamic> json) =>
      User(
        id : json["id"],
        nom : json["nom"],
        prenom : json["prenom"],
        cin : json["cin"],
        status : json["status"],
        id_local : json["id_local"],
      );

  Map<String, dynamic> toMap() =>
      {
        "id": id,
        "nom": nom,
        "prenom": prenom,
        "cin": cin,
        "status": status,
        "id_local": id_local,
      };

}