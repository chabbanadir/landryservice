import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:landryservice/Widgets/Buttom.dart';
import 'package:landryservice/classes/Local.dart';
import 'package:landryservice/classes/user.dart';

class UserInterface extends StatefulWidget {
  @override
  _UserInterfaceState createState() => _UserInterfaceState();
}

class _UserInterfaceState extends State<UserInterface> {
  @override
  Widget build(BuildContext context) {
    //appbar
    final appbar = AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.blue[800],
      title: Text('Landry Service'),
      actions: <Widget>[
        SizedBox(
          width: 15.0,
        ),
        IconButton(
          icon: Icon(Icons.power_settings_new),
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
        ),
      ],
    );

    //user information
    final card = Card(
      margin: EdgeInsets.all(10.0),
      borderOnForeground: debugInstrumentationEnabled,
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.blue,
            backgroundImage: AssetImage('lib/assets/logo.jpg'),
            radius: 20.0,
          ),
          SizedBox(width: 10.0),
          Container(
            decoration: BoxDecoration(),
            padding: EdgeInsets.all(15.0),
            child: Text(User.curentUser.nom,
              style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Open Sans',
                  fontSize: 20),),
          ),
          SizedBox(width: 70.0),
          Container(
            decoration: BoxDecoration(),
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Solde',
              style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Open Sans',
                  fontSize: 20),
            ),
          ),
          SizedBox(width: 10.0),
          Container(
            decoration: BoxDecoration(),
            padding: EdgeInsets.all(15.0),
            child: Text(
              Local.curentUser.solde,
              style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Open Sans',
                  fontSize: 20),
            ),
          ),
        ],
      ),
    );

    // buttom add
    final btnAdd = Container(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Buttoms(
          iconSize: 70.0,
          iconButton: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, '/addcommande');
          },
        ),
      ),
    );

    // buttom search
    final btnSerach = Container(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: Buttoms(
          iconSize: 70.0,
          iconButton: Icon(Icons.search),
          onPressed: () {
            Navigator.pushNamed(context, '/cherchercommande');
          },
        ),
      ),
    );

    //buttomn valide
    final btnValide = Container(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: Buttoms(
          iconSize: 70.0,
          iconButton: Icon(Icons.contacts),
          onPressed: () {
            Navigator.pushNamed(context, '/ajouterclient');
          },
        ),
      ),
    );

    void test() {
      print("test");
    }

    //buttomn notification
    final btnNotification = Container(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: Buttoms(
          iconSize: 70.0,
          iconButton: Icon(Icons.portrait),
          onPressed: () {
            print("buton pressed");
          },
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: appbar,
      body: Column(
        children: <Widget>[
          card,
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              btnAdd,
              btnSerach,
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              btnValide,
              // btnNotification,
            ],
          ),
        ],
      ),
    );
  }
}
