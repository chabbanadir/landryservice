
import 'package:flutter/material.dart';

enum DialogAction { yes, abort }

class Dialogs {

  static Future<DialogAction> yesAbortDialog(
      BuildContext context,
      String title,
      String body,

      ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(title),
          content: Container(
            child: Column(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    onSaved: (input){
                      print(input);
                    },
                    decoration: const InputDecoration(
                    icon: Icon(Icons.local_offer),
                    hintText: 'Réference',
                    labelText: 'Réference',
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Flexible(
                  flex: 1,
                  child: Text("Date"),
                ),
                SizedBox(height: 20,),
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    onChanged: (input){
                      print(input);
                    },
                    decoration: const InputDecoration(
                      icon: Icon(Icons.redeem),
                      hintText: 'Quantité',
                      labelText: 'Quantité',
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Flexible(
                  flex: 1,
                  child: Text("Prix"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(DialogAction.abort),
              child: const Text('No'),
            ),
            RaisedButton(
              onPressed: () => Navigator.of(context).pop(DialogAction.yes),
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }
}