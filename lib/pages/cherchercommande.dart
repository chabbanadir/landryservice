import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:landryservice/Widgets/datasearch.dart';
import 'package:landryservice/classes/Local.dart';
import 'package:landryservice/classes/client.dart';
import 'package:landryservice/classes/commande.dart';
import 'package:landryservice/classes/ligne_commande.dart';
import 'package:landryservice/classes/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ChercherCommande extends StatefulWidget {
  @override
  _ChercherCommandeState createState() => _ChercherCommandeState();
}

class _ChercherCommandeState extends State<ChercherCommande> {
  // variables

  int inde;
  static var commandes = [];
  static List<Commande> listcommandes = [];
  static List<LigneCommande> listlignecommande = [];
  static Client client;
  String ref = "";

  void getdata(int i) async {
    final response = await http.post(
        "http://192.168.1.102/landryservice/getallcommande.php",
        body: {'id_local': i.toString()});
    var message = jsonDecode(response.body);
    setState(() {
      for (var i = 0; i < message.length; i++) {
        listcommandes.add(Commande(
            paye: (message[i]['paye'] == 0.toString()) ? false : true,
            date: message[i]['date'],
            sortie: (message[i]['sortie'] == 0.toString()) ? false : true,
            id_local: int.parse(message[i]['id_local']),
            id_user: int.parse(message[i]['id_user']),
            num_commande: int.parse(message[i]['num_commande']),
            prix: int.parse(message[i]['prix']),
            id_client: int.parse(message[i]['id_client'])));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    commandes = [];
    listcommandes = [];
    getdata(User.curentUser.id_local);
    commandes = listcommandes;
    datasearch = Datasearch(list: commandes);
  }

  Datasearch datasearch;
  Commande commande;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Listes des Commande'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                await showSearch(context: context, delegate: datasearch);
                Duration(seconds: 7);
                commande = Commande.copy(datasearch.commande);
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/addcommande');
        },
        label: Text('Ajouter commande'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: ListView.builder(
            itemCount: commandes.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.all(15),
                height: 120,
                width: 150,
                child: Card(
                  color: commandes[index].color,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.event_note),
                          Text('Num commande : '),
                          Text(commandes[index].num_commande.toString()),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            icon: Icon(Icons.publish),
                            onPressed: () async {
                              inde = index;
                              validcommande(
                                  commandes[index].num_commande.toString(),
                                  commandes[index].id_client.toString());
                              setState(() {});
                            },
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.attach_money),
                          Text('Payer : '),
                          Text(commandes[index].paye.toString()),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Future<List> getlignecommande(String num_cmd) async {
    print('done');
    ref = '';
    final response = await http
        .post("http://192.168.1.102/landryservice/getlignecommande.php", body: {
      'num_commande': num_cmd,
    });
    var message = jsonDecode(response.body);
    for (var i = 0; i < message.length; i++) {
      listlignecommande.add(LigneCommande.fromMap(message[i]));
      ref = ref + ' ' + '${i + 1})' + listlignecommande[i].reference;
      if (i%1==0) ref = ref + '\n';
    }
    print(ref);
  }

  Future<List> getclient(String id_client) async {
    print('done');
    final response = await http
        .post("http://192.168.1.102/landryservice/getclientid.php", body: {
      'id_client': id_client,
    });
    var message = jsonDecode(response.body);
    client = Client.fromMap2(message[0]);
  }

  void validcommande(String num_cmd, String id_client) async {
    listlignecommande = [];
    await getclient(id_client);
    await getlignecommande(num_cmd);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Check-out'),
            content: Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Num Commande :  '),
                      Text(num_cmd),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Text('Payer :  '),
                      Text((commandes[inde].paye.toString() == true)
                          ? 'oui'
                          : 'oui'),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Text('Nom :  '),
                      Text(client.nom_client),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Text('telephone :  '),
                      Text(client.num_telephone),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Text('Prix :  '),
                      Text(commandes[inde].prix.toString()),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Text('Date :  '),
                      Text(DateFormat('yyyy-MM-dd – kk:mm')
                          .format(DateTime.parse(commandes[inde].date))),
                    ],
                  ),    Container(
                    width: double.infinity,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Text('reference :  '),
                      Text(ref),
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
                 await checkout(commandes[inde].num_commande.toString());
                 setState(() {
                   int solde = int.parse(Local.curentUser.solde);
                   solde += commandes[inde].prix;
                   print(solde);
                   Local.curentUser.solde = solde.toString();
                   commandes = [];
                   listcommandes = [];
                   getdata(User.curentUser.id_local);
                   commandes = listcommandes;
                   datasearch = Datasearch(list: commandes);
                 });
                 await soldes();
                 Navigator.of(context).pop();
                },
                icon: Icon(Icons.archive),

              ),
              IconButton(
                onPressed: () async{
                  setState(() {
                    commandes[inde].color = Colors.green;
                  });
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.done),
              ),
            ],
          );
        });
  }
  Future<List> checkout( String num_commande) async {
    final response = await http.post("http://192.168.1.102/landryservice/checkoutcommande.php", body :{
      'num_commande' : num_commande,
      'date_sortie' : DateTime.now().toIso8601String(),
    });
    //var message = jsonDecode(response.body);
    print(response.body);

  }
  Future<List> soldes() async {
    final response = await http.post("http://192.168.1.102/landryservice/solde.php", body :{
      'id_local' : User.curentUser.id_local.toString(),
      'solde' : Local.curentUser.solde,
    });
    //var message = jsonDecode(response.body);
    print(response.body);
  }
}
