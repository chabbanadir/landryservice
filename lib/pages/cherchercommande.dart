import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:landryservice/Widgets/datasearch.dart';
import 'package:landryservice/classes/commande.dart';
import 'package:landryservice/classes/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChercherCommande extends StatefulWidget {
  @override
  _ChercherCommandeState createState() => _ChercherCommandeState();
}

class _ChercherCommandeState extends State<ChercherCommande> {
  // variables
  static var commandes = [];
  static List<Commande> listcommandes = [];

  void getdata(int i) async {
    final response = await http.post(
        "http://192.168.1.117/landryservice/getallcommande.php",
        body: {'id_local': i.toString()});
    var message = jsonDecode(response.body);
    setState(() {
      for (var i = 0; i < message.length; i++) {
        listcommandes.add(Commande(
            paye: (message[i]['paye'] == 0 ) ? false: true,
            date: message[i]['date'],
            sortie: (message[i]['sortie'] == 0 ) ? false : true,
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
    listcommandes= [];
    getdata(User.curentUser.id_local);
    commandes = listcommandes ;
  }

  Datasearch datasearch = Datasearch(list: commandes);
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
      body: Container(
        child: ListView.builder(
            itemCount: commandes.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.all(15),
                height: 120,
                width: 150,
                child: Card(
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
                              print('${commandes[index].num_commande}');

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
}
