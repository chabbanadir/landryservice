class Local{
  int id_local;
  String adresse="";
  String solde;
  String nom_local;

  static Local curentUser;

  Local(this.id_local, this.adresse, this.solde, this.nom_local){
    curentUser = this;
  }

  Local.map(List<dynamic> data){
    id_local = int.parse(data[0]['id_local']);
    adresse = data[0]['adresse'];
    solde = data[0]['solde'];
    nom_local = data[0]['nom_local'];

    curentUser = this;
  }

}