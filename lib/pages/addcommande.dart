import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:landryservice/Widgets/datasearch.dart';
import 'package:landryservice/classes/client.dart';
import 'package:landryservice/classes/commande.dart';
import 'package:landryservice/classes/ligne_commande.dart';
import 'package:landryservice/classes/services.dart';
import 'package:landryservice/classes/user.dart';
class AddCommande extends StatefulWidget {
  @override
  _AddCommandeState createState() => _AddCommandeState();
}

class _AddCommandeState extends State<AddCommande> {
  // variables
  TextEditingController reference = TextEditingController();
  TextEditingController quantite = TextEditingController();
  TextEditingController nom_client = TextEditingController();
  TextEditingController prenom_client = TextEditingController();
  TextEditingController num_client = TextEditingController();

  int num_cmd= 1;
  Client client;
  static List<Client> clientlist = [];
  Datasearch datasearch;
  List<LigneCommande> ligneCommandes = [];
  Commande commande;
  String services;
  var ligneCommande;
  Services serv;
  int prix = 0;
  bool sechage = false;
  List menu = [
    {'id_service': 1, 'nom_service': '5 kg', 'prix_u': 35},
    {'id_service': 2, 'nom_service': '8 kg', 'prix_u': 50},
    {'id_service': 3, 'nom_service': 'séchage', 'prix_u': 20},
    {'id_service': 4, 'nom_service': 'couverture', 'prix_u': 20},
    {'id_service': 5, 'nom_service': 'espadrille', 'prix_u': 15},
    {'id_service': 6, 'nom_service': 'tapis', 'prix_u': 20}
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clientlist =[];
    setState(() {
      getallclient();
      Duration(seconds: 2);
      datasearch = Datasearch(list: clientlist );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Ajouter Commande'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                await showSearch(context: context, delegate: datasearch);
                Duration(seconds: 7);
                (datasearch.client == null ) ? null :  client = Client.copy(datasearch.client);
              }),
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.blue[200],
              constraints: BoxConstraints.expand(height: 50.0),
              padding: EdgeInsets.all(10),
              child: Center(
                child: DropdownButton(
                  hint: Text("Select Your Service"),
                  onChanged: (value) {
                    setState(() {
                      clearTextController();
                      services = value;
                    });
                  },
                  value: services,
                  items: menu.map((value) {
                    return DropdownMenuItem(
                      child: Text(value['nom_service']),
                      value: value['nom_service'],
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey[200],
              constraints: BoxConstraints.expand(height: 275.0),
              padding: EdgeInsets.all(10),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: reference,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.local_offer),
                        hintText: 'Réference',
                        labelText: 'Réference',
                      ),
                    ),
                    Container(
                      width: double.infinity,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                    ),
                    TextFormField(
                      controller: quantite,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.local_offer),
                        hintText: 'Quantité',
                        labelText: 'Quantité',
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          'Séchage',
                          style: TextStyle(fontSize: 18),
                        ),
                        Checkbox(
                            value: sechage,
                            onChanged: (bool newValue) {
                              setState(() {
                                sechage = newValue;
                              });
                            }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: Colors.blue[400]),
                            child: IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: _addCommande,
                            )),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.blue[400]),
                          child: IconButton(
                            icon: Icon(
                              Icons.account_circle,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/ajouterclient');
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.green[400]),
                          child: IconButton(
                            icon: Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: _validecommande,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: ListView.builder(
                itemCount: ligneCommandes.length,
                // ignore: missing_return
                itemBuilder: (BuildContext context, int index) => ListTile(
                  title: Text(
                    'Réference :' + ligneCommandes[index].reference,
                    style: TextStyle(fontSize: 18),
                  ),
                  subtitle: Text(
                    'Prix:  ' +
                        ligneCommandes[index].prix.toString() +
                        '     ||||||       Service:  ' +
                        ' Client :  ' +
                        '${datasearch.client.num_telephone}',
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: Icon(Icons.delete),
                  onTap: () {
                    setState(() {
                      ligneCommandes.removeAt(index);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void clearTextController() {
    reference.clear();
    quantite.clear();
    nom_client.clear();
    nom_client.clear();
    num_client.clear();
  }
  void _addCommande() {
    for (var i = 0; i < menu.length; i++) {
      if (services == menu[i]['nom_service'])
        serv = Services(
            nom_service: menu[i]['nom_service'],
            prix: menu[i]['prix_u'],
            id_service: menu[i]['id_service']);
    }
    setState(() {
      ligneCommande = LigneCommande(
          quantite: int.parse(quantite.text),
          reference: reference.text,
          id_service: serv.id_service,
          num_commande: num_cmd,
          prix: (serv.nom_service == 'couverture' ||
              serv.nom_service == 'espadrille' ||
              serv.nom_service == 'tapis' ||
              serv.nom_service == 'séchage')
              ? int.parse(quantite.text) * serv.prix
              : (sechage)
              ? int.parse(quantite.text) * (serv.prix + 10)
              : int.parse(quantite.text) * serv.prix);
      ligneCommandes.add(ligneCommande);

      quantite.clear();
      reference.clear();
    });
  }

  void _validecommande() {
    prix = 0;
    String referenceligne = '';
    for (var i = 0; i < ligneCommandes.length; i++) {
      prix += ligneCommandes[i].prix;
      (ligneCommandes.length > 1)
          ? (referenceligne =
          referenceligne + ligneCommandes[i].reference + ' / ')
          : referenceligne = ligneCommandes[i].reference;
    }

    commande = Commande(
      id_client: client.id_client,
      prix: prix,
      num_commande: num_cmd,
      id_user: User.curentUser.id,
      id_local: User.curentUser.id_local,
      sortie: false,
      date: DateTime.now().toIso8601String(),
      paye: false,
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text('Valider commande'),
              content: Container(
                height: 300,
                width: 300,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('Client : '),
                        SizedBox(
                          width: 15,
                        ),
                        Text('${client.num_telephone}'),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Text('Prix : '),
                        SizedBox(
                          width: 15,
                        ),
                        Text('$prix'),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Text('Num commande : '),
                        SizedBox(
                          width: 15,
                        ),
                        Text('ref'),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Text('Reference : '),
                        SizedBox(
                          width: 15,
                        ),
                        Text(referenceligne),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('Payer : '),
                        SizedBox(
                          width: 15,
                        ),
                        Checkbox(
                            value: commande.paye,
                            onChanged: (bool value) {
                              setState(() {
                                commande.paye = value;
                              });
                            })
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                  },
                  icon: Icon(Icons.sms),
                ),
                IconButton(
                  onPressed: () async{
                   await insertcommande(commande);
                    for(var i=0 ; i< ligneCommandes.length ; i++){
                      print(num_cmd);
                      ligneCommandes[i].num_commande = num_cmd;
                      await insertligne(ligneCommandes[i]);
                    }

                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.done),
                ),
              ],
            );
          });
        });
  }
  Future<List> getallclient() async {
    print ('done');
    final response = await http.post("http://192.168.1.117/landryservice/getallclient.php");
    var message = jsonDecode(response.body);
    for( var i=0; i<message.length; i++){
      clientlist.add(Client.fromMap2(message[i]));
    }
  }
  Future<List> insertligne(LigneCommande ligneCo) async {
    final response = await http.post("http://192.168.1.117/landryservice/insertlignecommande.php", body :{
      'reference' : ligneCo.reference,
      'quantite' : ligneCo.quantite.toString(),
      'id_service' : ligneCo.id_service.toString(),
      'num_commande' : ligneCo.num_commande.toString(),
      'prix' : ligneCo.prix.toString(),
    });
   //var message = jsonDecode(response.body);
   print(response.body);
  }
  Future insertcommande(Commande Co) async {
    final response = await http.post("http://192.168.1.117/landryservice/insertcomande.php", body :{
      'id_client' : Co.id_client.toString(),
      'prix' : Co.prix.toString(),
      //'num_commande' : Co.num_commande.toString(),
      'id_user' : Co.id_user.toString(),
      'id_local' : Co.id_local.toString(),
      'sortie' : false.toString(),
      'date' : Co.date.toString(),
      'paye' : false.toString(),
    });

    var message = jsonDecode(response.body);

    if(message['success']){
      print("called");
      num_cmd = message['msg'];
    }else{
      print(message['msg']);
    }
  }

}

