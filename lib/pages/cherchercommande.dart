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

  void getdata(int i) async{

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    commandes =[];
    getdata(User.curentUser.id_local);
  }
  Datasearch datasearch = Datasearch(list: commandes );
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
                    child: Column(children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.event_note),
                          Text('Num commande : '),
                          Text(commandes[index].num_commande.toString()),
                          SizedBox(width: 10,),
                          IconButton(icon: Icon(Icons.publish),onPressed: () async{
                            print('${commandes[index].num_commande}');

                            setState((){

                            });

                          },)
                          ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.attach_money),
                          Text('Payer : '),
                          Text(commandes[index].paye.toString()),
                          SizedBox(width: 10,),
                        ],
                      ),
                    ],
                    ),
                ),
              );
            }
        ),
      ),
    );
  }
}
