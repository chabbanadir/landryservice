import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:landryservice/classes/user.dart';

class LogginInterface extends StatefulWidget {
  @override
  _LogginState createState() => _LogginState();
}

class _LogginState extends State<LogginInterface> {
  TextEditingController usernames = TextEditingController();
  TextEditingController passwords = TextEditingController();
  User user;

  Future<List>_login() async{
    final response = await http.post("http://192.168.1.117/landryservice/login.php", body: {
      "username" : usernames.text,
      "password" : passwords.text,
    });
    var data = json.decode(response.body);
    print(data);
    user = User.map(data);
    print(user.toString());
    switch(user.status){
      case 'user' :{
        Navigator.pushReplacementNamed(context, '/userinterface',arguments: data);
      }
      break;
      case 'superadmin':{
        Navigator.pushReplacementNamed(context, '/admininterface');
      }
      break;
      case 'admin':{
        Navigator.pushReplacementNamed(context, '/admininterface');
      }
      break;
      default: {

      }
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo =  CircleAvatar(
        backgroundColor: Colors.blue,
        radius: 48.0,
        child: Image.asset(''),
    );
    final username = TextField(
      controller: usernames,
      decoration: InputDecoration(
        hintText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final password = TextField(
      controller: passwords,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          print(username);
          print(password);
           _login();
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );



    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            username,
            SizedBox(height: 8.0),
            password,
            loginButton,
          ],
        ),
      ),
    );
  }
}
