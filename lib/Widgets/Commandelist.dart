import 'package:flutter/material.dart';
import 'package:landryservice/classes/ligne_commande.dart';

class Commandelist extends StatelessWidget {
  LigneCommande ligneCommande;
  Function delete;

  Commandelist({this.delete, this.ligneCommande});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                 'Reference: ',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[600],
                  ),
                ),
                Text(ligneCommande.reference.toString()),
                Text(
                  '     - Prix: ',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[800],
                  ),
                ),
                Text(ligneCommande.prix.toString())
              ],
            ),
            FlatButton.icon(
                onPressed: delete,
                icon: Icon(Icons.delete),
                label: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}