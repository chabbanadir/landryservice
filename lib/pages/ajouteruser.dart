import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:landryservice/classes/client.dart';
import 'package:landryservice/classes/user.dart';


class AjouterUser extends StatefulWidget {
  @override
  _AjouterUserState createState() => _AjouterUserState();
}

class _AjouterUserState extends State<AjouterUser> {
  TextEditingController nom_user = TextEditingController();
  TextEditingController prenom_user = TextEditingController();
  TextEditingController cin = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();

  bool fidel = false;
  Client client;
  String admin;

  Future<List> newuser() async {
    print ('done');
    final response = await http.post("http://192.168.1.102/landryservice/insertuser.php", body: {
      'nom_user': nom_user.text,
      'prenom_user': prenom_user.text,
      'cin':cin.text,
      'email': mail.text,
      'status':admin,
      'id_local' : User.curentUser.id_local.toString(),
      'password' : password.text,
    });
    var message = jsonDecode(response.body);
    print(response.body);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Ajouter User'),
      ),
      body: Container(
        constraints: BoxConstraints.expand(height: 700.0),
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: nom_user,
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
                controller: prenom_user,
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
                controller: cin,
                decoration: const InputDecoration(
                  icon: Icon(Icons.perm_contact_calendar),
                  hintText: 'CIN',
                  labelText: 'CIN',
                ),
              ),
              Container(
                width: double.infinity,
              ),
              TextField(
                controller: mail,
                decoration: const InputDecoration(
                  icon: Icon(Icons.mail),
                  hintText: 'Mail',
                  labelText: 'Mail',
                ),
              ),
              Container(
                width: double.infinity,
              ),TextField(
                controller: password,
                decoration: const InputDecoration(
                  icon: Icon(Icons.vpn_key),
                  hintText: 'Password',
                  labelText: 'Password',
                ),
              ),
              Container(
                width: double.infinity,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Admin',
                    style: TextStyle(fontSize: 18),
                  ),
                  Checkbox(
                      value: fidel,
                      onChanged: (bool newValue) {
                        setState(() {
                          fidel = newValue;
                          if (fidel) admin="admin";
                          else admin = "user";
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
                    onPressed: ()  {
                      newuser();
                      Navigator.pop(context);
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