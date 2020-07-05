import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:landryservice/classes/client.dart';


class AjouterClient extends StatefulWidget {
  @override
  _AjouterClientState createState() => _AjouterClientState();
}

class _AjouterClientState extends State<AjouterClient> {
  TextEditingController nom_client = TextEditingController();
  TextEditingController prenom_client = TextEditingController();
  TextEditingController num_client = TextEditingController();
  TextEditingController mail_client = TextEditingController();

  bool fidel = false;
  Client client;

  Future<List> newuser() async {
    print ('done');
    final response = await http.post("http://192.168.1.117/landryservice/insertclient.php", body: {
      'nom_client': nom_client.text,
      'prenom_client': prenom_client.text,
      'num_telephone':num_client.text,
      'mail_client':mail_client.text,
      'fidel':fidel.toString(),
    });
    var message = jsonDecode(response.body);
    print(message);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Ajouter Client'),
      ),
      body: Container(
        constraints: BoxConstraints.expand(height: 400.0),
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: nom_client,
                decoration: const InputDecoration(
                  icon: Icon(Icons.contacts),
                  hintText: 'Nom',
                  labelText: 'Nom',
                ),
              ),
              Container(
                width: double.infinity,
              ),
              TextField(
                controller: prenom_client,
                decoration: const InputDecoration(
                  icon: Icon(Icons.contacts),
                  hintText: 'Prenom',
                  labelText: 'Prenom',
                ),
              ),
              Container(
                width: double.infinity,
              ),
              TextField(
                controller: num_client,
                decoration: const InputDecoration(
                  icon: Icon(Icons.phone),
                  hintText: 'Téléphone',
                  labelText: 'Téléphone',
                ),
              ),
              Container(
                width: double.infinity,
              ),
              TextField(
                controller: mail_client,
                decoration: const InputDecoration(
                  icon: Icon(Icons.mail),
                  hintText: 'Mail Client',
                  labelText: 'Mail Client',
                ),
              ),
              Container(
                width: double.infinity,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Fidel',
                    style: TextStyle(fontSize: 18),
                  ),
                  Checkbox(
                      value: fidel,
                      onChanged: (bool newValue) {
                        setState(() {
                          fidel = newValue;
                        });
                      }),
                ],
              ),
              Container(
                width: double.infinity,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: ()async{

                    },
                    child: Text('delet all client'),
                  ),
                  RaisedButton(
                    onPressed: ()  {
                      newuser();

//                      await ClientDatabaseProvider.db.newClient(client);

                      //Navigator.pop(context);
                    },
                    child: Text('Ajouter'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}