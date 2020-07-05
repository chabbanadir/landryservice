import 'package:flutter/material.dart';
import 'package:landryservice/classes/client.dart';
import 'package:landryservice/classes/commande.dart';

class Datasearch extends SearchDelegate<String> {
  final Function onTap;
  Client client;
  Commande commande;
  List list;
  var lastsearch = [];

  Datasearch({this.onTap,this.list});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = " ";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close((context), null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {

    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var suggestionList = [];
    String name='';
    String number='';
    int search = 0;
    if (query.isEmpty) {
      suggestionList = lastsearch;
    } else {
      for (var i = 0; i < list.length; i++) {
        if(list[i] is Client){
          name = list[i].prenom_client;
          number =  list[i].num_telephone;
        }else if(list[i] is Commande){
          name = '${list[i].num_commande}';
          number =  list[i].date.toString();
        }
        if (name.toLowerCase().contains(query.toLowerCase()) || number.toLowerCase().contains(query.toLowerCase())) {
          suggestionList.add(list[i]);
          search++;
        }
      }
    }

    return ListView.builder(
      itemCount: (search <= 1) ? suggestionList.length : search,
      itemBuilder: (context, index) => ListTile(
        onTap: (){
          lastsearch.add(suggestionList[index]);
          if(lastsearch.length > 3 ) {
            lastsearch = [];
            lastsearch.add(suggestionList[index]);
          }
         if (list[index] is Client) {
           client = Client.copy(suggestionList[index]);
           close(context, '${suggestionList[index].num_telephone}');
         }else {
           commande = Commande.copy(suggestionList[index]);
           close(context, '${suggestionList[index].num_commande.toString()}');
         }
          //print(client.nom_client);
        },
        leading: Icon(Icons.contacts),
        title: RichText(
          text: TextSpan(
            text:(list[index] is Client)? suggestionList[index].prenom_client : suggestionList[index].num_commande.toString() ,
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                text:(list[index] is Client)? '  -Number :${suggestionList[index].num_telephone}' : ' -Payer : ${suggestionList[index].paye.toString()}',
              style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
