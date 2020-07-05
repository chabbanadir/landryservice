import'package:flutter/material.dart';
import 'package:landryservice/pages/addcommande.dart';
import 'package:landryservice/pages/ajouterclient.dart';
import 'package:landryservice/pages/cherchercommande.dart';
import 'package:landryservice/pages/userInterface.dart';
import 'package:landryservice/pages/LogginInterface.dart';
import 'package:landryservice/pages/AdminInterface.dart';


void main () => runApp(new MyApp());

final routes ={
  '/cherchercommande' : (BuildContext context ) => new ChercherCommande(),
  '/ajouterclient': (BuildContext context ) => new AjouterClient(),
  '/login': (BuildContext context ) => new LogginInterface(),
  '/userinterface': (BuildContext context ) => new UserInterface(),
  '/admininterface': (BuildContext context ) => new AdminInterface(),
  '/addcommande': (BuildContext context ) => new AddCommande(),
  '/': (BuildContext context ) => new LogginInterface(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laundry Service',
      routes: routes,
    );
  }
}
