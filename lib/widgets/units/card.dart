import 'package:flutter/material.dart';

class KCard extends StatelessWidget {
  final String fName, lName, imgUrl, title, description;
  KCard({this.fName, this.lName, this.imgUrl, this.title, this.description});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(imgUrl, height: 30.0, width: 30.0),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0,4.0,2.0,4.0),
              child: Text(fName),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4.0,4.0,2.0,4.0),
              child: Text(lName),
            ),
          ]),
          Row(
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                description,
                style: TextStyle(
                  fontSize: 14.0,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
