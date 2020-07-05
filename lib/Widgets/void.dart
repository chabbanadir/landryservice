/*
Widget DropDown(List data) {
  if (data != null) {
    return DropdownButton(
      items: data.map((item) {
        return new DropdownMenuItem(
          child: new Text(
            item['nom_service'],
            style: TextStyle(fontSize: 14.0),
          ),
          value: item['nom_service'].toString(),
        );
      }).toList(),
      hint: Text(
        "Choix du services ",
        style: TextStyle(
          color: Colors.black45,
        ),
      ),
      onChanged: (newVal) {
        setState(() {
          _mySelection = newVal;
        });
      },
      value: _mySelection,
    );
  } else {
    return new Center(
      child: CircularProgressIndicator(),
    );
  }
}*/
