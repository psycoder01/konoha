import 'package:flutter/material.dart';

class KCard extends StatelessWidget {
  final String name, imgUrl, content;
  KCard({this.name, this.imgUrl, this.content});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(imgUrl, height: 30.0, width: 30.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 4.0, 2.0, 4.0),
              child: Text(name),
            ),
          ]),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  content,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
